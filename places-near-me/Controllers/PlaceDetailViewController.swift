//
//  PlaceDetailViewController.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol GetCommentsProtocol {
    func getCommentsById(id: String)
}

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var placeImagesCollectionView: UICollectionView!
    @IBOutlet weak var placeCategoriesCollectionView: UICollectionView!
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var lblStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var delegate: GetCommentsProtocol?
    
    var placeDetails: PlaceDetailsViewModel? {
        didSet {
            editFields()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeImagesCollectionView.register(PlaceDetailCollectionViewCell.self, forCellWithReuseIdentifier: "placeImageCell")
        placeImagesCollectionView.delegate = self
        placeImagesCollectionView.dataSource = self
        
        placeCategoriesCollectionView.register(PlaceCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "placeCategoryCell")
        placeCategoriesCollectionView.delegate = self
        placeCategoriesCollectionView.dataSource = self
    }
    
    fileprivate func editFields() {
        title = placeDetails?.placeName
        
        if let score = placeDetails?.rating {
            let starView = RatingStarView()
            starView.rating = score
            starView.btnComments.addTarget(self, action: #selector(btnCommendPress), for: .touchUpInside)
            ratingStackView.addSubview(starView)
            
            starView.anchor(top: placeCategoriesCollectionView.bottomAnchor, bottom: mapView.topAnchor, leading: lblStackView.trailingAnchor, trailing: self.view.trailingAnchor, padding: .init(top: 10, left: 8, bottom: 25, right: 20))
            starView.centerYAnchor.constraint(equalTo: lblStackView.centerYAnchor).isActive = true
        }
        
        lblPlace.text = placeDetails?.phoneNumber
        lblPrice.text = placeDetails?.price
        lblTime.text = placeDetails?.isClosed
        
        placeImagesCollectionView.reloadData()
        placeCategoriesCollectionView.reloadData()
        
        showCoordinates()
    }
    
    fileprivate func showCoordinates() {
        if let coordinate = placeDetails?.coordinates {
            let area = MKCoordinateRegion(center: coordinate, latitudinalMeters: 120, longitudinalMeters: 120)
            mapView.setRegion(area, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = placeDetails?.placeName
            mapView.addAnnotation(pin)
        }
    }
    
    @objc fileprivate func btnCommendPress() {
        guard let commentsVC = storyboard?.instantiateViewController(identifier: "CommentsViewController") else { return }
        navigationController?.pushViewController(commentsVC, animated: true)
        delegate?.getCommentsById(id: placeDetails!.id)
    }
}

extension PlaceDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == placeImagesCollectionView {
            return placeDetails?.placePhotos.count ?? 0
        }
        return placeDetails?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == placeImagesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeImageCell", for: indexPath) as! PlaceDetailCollectionViewCell
            if let imageUrl = placeDetails?.placePhotos[indexPath.row] {
                cell.placeImg.af.setImage(withURL: imageUrl)
            }
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCategoryCell", for: indexPath) as! PlaceCategoriesCollectionViewCell
        cell.lblCategory.text = placeDetails?.categories[indexPath.row].title
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == placeImagesCollectionView {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
        return CGSize(width: 70, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}


