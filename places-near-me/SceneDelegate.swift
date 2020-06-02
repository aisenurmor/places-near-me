//
//  SceneDelegate.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let window = UIWindow()
    let locationService = LocationService()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    let networkService = MoyaProvider<YelpServices.DataProvider>()
    let decoder = JSONDecoder()
    var navigationController: UINavigationController?
    
    //MARK: - Filter words entered by the user
    var searchPhrase: String? {
        didSet {
            if self.searchPhrase!.isEmpty {
                getPlaces(coordinate: locationService.userLocation!)
            } else {
                getPlaces(coordinate: locationService.userLocation!, filter: searchPhrase!)
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        locationService.currentLocation = { result in
            switch result {
            case .success(let location):
                self.getPlaces(coordinate: location.coordinate)
            case .failure(let error):
                print("Error, \(error)")
            }
        }
    
        window.windowScene = windowScene
        window.makeKeyAndVisible()
        
        switch locationService.status {
        case .denied, .notDetermined, .restricted:
            let locationVC = storyBoard.instantiateViewController(identifier: "LandingViewController") as? LandingViewController
            locationVC?.delegate = self
            window.rootViewController = locationVC
            
        default:
            let navigation = storyBoard.instantiateViewController(identifier: "PlacesNavigationController") as? UINavigationController
            window.rootViewController = navigation
            navigationController = navigation
            locationService.getLocation()
            (navigation?.topViewController as? MainViewController)?.delegate = self
        }
    }
    
    //MARK: - Get details of the place the user clicked
    private func getDetails(placeId: String) {
        print(placeId)
        networkService.request(.details(id: placeId)) { (result) in
            
            switch result {
            case .success(let resultData):
                if let details = try? self.decoder.decode(PlaceDetails.self, from: resultData.data) {
                    let placeDetails = PlaceDetailsViewModel(detail: details)
                    let detailsVC = (self.navigationController?.topViewController as? PlaceDetailViewController)
                    detailsVC?.placeDetails = placeDetails
                    detailsVC?.delegate = self
                }
                
            case .failure(let error):
                print("Error, \(error)")
            }
        }
    }
    
    //MARK: - Get places near current location
    private func getPlaces(coordinate: CLLocationCoordinate2D) {
        networkService.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { (result) in
            
            switch result {
            case .success(let resultData):
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let data = try? self.decoder.decode(AllData.self, from: resultData.data)
                let placeList = data?.businesses.compactMap(PlaceListViewModel.init).sorted(by: { $0.distance < $1.distance })
                
                if let navigation = self.window.rootViewController as? UINavigationController, let placesTVC = navigation.topViewController as? MainViewController {
                    placesTVC.placeList = placeList ?? []
                    
                } else if let nav = self.storyBoard.instantiateViewController(withIdentifier: "PlacesNavigationController") as? UINavigationController {
                    self.navigationController = nav
                    nav.modalPresentationStyle = .fullScreen
                    self.window.rootViewController?.present(nav, animated: true) {
                        (nav.topViewController as? MainViewController)?.delegate = self
                        (nav.topViewController as? MainViewController)?.placeList = placeList ?? []
                    }
                }
            case .failure(let error):
                print("Error, \(error)")
            }
        }
    }
    
    //MARK: - Get places near current location with filters
    private func getPlaces(coordinate: CLLocationCoordinate2D, filter: String) {
        networkService.request(.searchFilter(lat: coordinate.latitude, long: coordinate.longitude, filter: filter)) { (result) in
            
            switch result {
            case .success(let resultData):
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let data = try? self.decoder.decode(AllData.self, from: resultData.data)
                let placeList = data?.businesses.compactMap(PlaceListViewModel.init).sorted(by: { $0.distance < $1.distance })
                
                if let navigation = self.window.rootViewController as? UINavigationController, let placesTVC = navigation.topViewController as? MainViewController {
                    placesTVC.placeList = placeList ?? []
                    
                } else if let nav = self.storyBoard.instantiateViewController(withIdentifier: "PlacesNavigationController") as? UINavigationController {
                    self.navigationController = nav
                    nav.modalPresentationStyle = .fullScreen
                    self.window.rootViewController?.present(nav, animated: true) {
                        (nav.topViewController as? MainViewController)?.delegate = self
                        (nav.topViewController as? MainViewController)?.placeList = placeList ?? []
                    }
                }
            case .failure(let error):
                print("Error, \(error)")
            }
        }
    }
    
    //MARK: - Get user comments to the place the user clicked
    fileprivate func getComments(placeId: String) {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        networkService.request(.reviews(id: placeId)) { (result) in
            switch result {
            case .success(let data):
                if let comments = try? self.decoder.decode(Response.self, from: data.data) {
                    let commentsVC = (self.navigationController?.topViewController as? CommentsViewController)
                    commentsVC?.comments = comments.reviews
//                    let commentsVC = self.storyBoard.instantiateViewController(identifier: "CommentsViewController") as! CommentsViewController
//                    commentsVC.comments = commentTest
                } else {
                    print("Error decoding comments")
                }
            case .failure(let error):
                print("Error, \(error)")
            }
        }
    }
}

extension SceneDelegate: SetLocationProtocol, PlacesListAction, GetCommentsProtocol {
    func getCommentsById(id: String) {
        getComments(placeId: id)
    }
    
    func chosePlace(place: PlaceListViewModel) {
        getDetails(placeId: place.id)
    }
    
    func allowed() {
        locationService.requestPermission()
    }
}
