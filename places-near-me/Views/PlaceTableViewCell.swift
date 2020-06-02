//
//  PlaceTableViewCell.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import AlamofireImage

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var placeView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var labelsStackView: UIStackView!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createGradientLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(place: PlaceListViewModel) {
        placeImageView.af.setImage(withURL: place.imageURL)
        lblDistance.text = place.distance
        lblPlaceName.text = place.placeName
        lblRating.text = String(place.rating)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = placeImageView.frame
        placeImageView.layer.insertSublayer(gradientLayer, at:1)
        
        ratingView.layer.cornerRadius = 5
        
        ratingView.bringSubviewToFront(placeImageView)
        placeImageView.layer.zPosition = 0
        ratingView.layer.zPosition = 1
        
        
        placeView.backgroundColor = .white
        placeView.layer.borderColor = UIColor.lightGray.cgColor
        placeView.layer.borderWidth = 0.7
        placeView.layer.cornerRadius = 8
        placeView.clipsToBounds = true
        
        labelsStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 4, right: 8)
        labelsStackView.isLayoutMarginsRelativeArrangement = true
    }
    
    //MARK: - Gradient Layer Operations
    fileprivate func createGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.4, 1.4]
        
        layer.addSublayer(gradientLayer)
    }
}
