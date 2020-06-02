//
//  LandingViewController.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

protocol SetLocationProtocol {
    func allowed()
}

class LandingViewController: UIViewController {
    
    var locationService: LocationService?
    
    @IBOutlet weak var landingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    
    var delegate: SetLocationProtocol?
    
    fileprivate let images: [UIImage] = [UIImage(named: "Home")!, UIImage(named: "Search")!, UIImage(named: "Detail")!, UIImage(named: "Comments")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editFields()
        
        locationService?.changeOfLocation = { success in
            if success {
                self.locationService?.getLocation()
            }
        }
    }
    
    fileprivate func editFields() {
        acceptButton.layer.cornerRadius = 7
        declineButton.layer.cornerRadius = 7
        
        landingCollectionView.register(PlaceDetailCollectionViewCell.self, forCellWithReuseIdentifier: "landingImageCell")
        landingCollectionView.delegate = self
        landingCollectionView.dataSource = self
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        delegate?.allowed()
    }
    
    @IBAction func declineButtonPressed(_ sender: UIButton) {
    }
}

extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "landingImageCell", for: indexPath) as! PlaceDetailCollectionViewCell
        let imageUrl = images[indexPath.row]
        cell.placeImg.image = imageUrl
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}
