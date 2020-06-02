//
//  PlaceDetailCollectionViewCell.swift
//  places-near-me
//
//  Created by aisenur on 27.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

class PlaceDetailCollectionViewCell: UICollectionViewCell {
    
    let placeImg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjust()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    fileprivate func adjust() {
        contentView.addSubview(placeImg)
        placeImg.translatesAutoresizingMaskIntoConstraints = false
        placeImg.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            placeImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
