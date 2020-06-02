//
//  PlaceCategoriesCollectionViewCell.swift
//  places-near-me
//
//  Created by aisenur on 27.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

class PlaceCategoriesCollectionViewCell: UICollectionViewCell {
    
    let lblCategory = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        adjust()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    fileprivate func adjust() {
        contentView.addSubview(lblCategory)
        
        backgroundColor = #colorLiteral(red: 0.9200581602, green: 0.9200581602, blue: 0.9200581602, alpha: 1)
        layer.cornerRadius = 3
        clipsToBounds = true
        
        lblCategory.preferredMaxLayoutWidth = 200
        lblCategory.textColor = UIColor.black
        lblCategory.textAlignment = .center
        lblCategory.font = UIFont.systemFont(ofSize: 17)
        
        lblCategory.translatesAutoresizingMaskIntoConstraints = false
        lblCategory.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblCategory.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblCategory.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 5, left: 8, bottom: 5, right: 8))
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
