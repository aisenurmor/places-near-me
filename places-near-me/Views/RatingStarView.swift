//
//  RatingStarView.swift
//  places-near-me
//
//  Created by aisenur on 29.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

class RatingStarView: UIStackView {

    var rating: Double = 0 {
        didSet {
            setUpStarStack()
        }
    }
    
    let btnComments = UIButton(type: .system)

    fileprivate func setUpStarStack() {
        
        let lblRating = UILabel()
        lblRating.text = "\(rating)/5"
        lblRating.font = .systemFont(ofSize: 28, weight: .medium)
        lblRating.textColor = #colorLiteral(red: 0.9753405452, green: 0.7711257339, blue: 0.301246047, alpha: 1)
        lblRating.textAlignment = .center
               
        let starSV = UIStackView()
        starSV.axis = .horizontal
        starSV.distribution = .fillEqually
        starSV.alignment = .fill
        starSV.spacing = 5
        starSV.tag = 1001
        
        var arrImageView = [UIImageView]()
        
        let remaining = 5-rating
        var notFillStar: Double = 0
        
        var roundedNumber = Int(rating)
        var fractionOfRating = rating.truncatingRemainder(dividingBy: 1)
        
        if (0 <= fractionOfRating && fractionOfRating < 0.4) {
            roundedNumber = Int(floor(rating))
            notFillStar = ceil(remaining)
        } else if (0.6 < fractionOfRating && fractionOfRating < 1) {
            roundedNumber = Int(ceil(rating))
            notFillStar = floor(remaining)
        } else {
            fractionOfRating = 1
            notFillStar = floor(remaining)
        }
        
        for _ in 1...roundedNumber {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "fillStar")
            imageView.tintColor = #colorLiteral(red: 0.9753405452, green: 0.7711257339, blue: 0.301246047, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            starSV.addArrangedSubview(imageView)
            arrImageView.append(imageView)
        }
        
        if fractionOfRating == 1 {
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "half-star")
            imageView.tintColor = #colorLiteral(red: 0.9294117647, green: 0.937254902, blue: 0.9450980392, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            starSV.addArrangedSubview(imageView)
            arrImageView.append(imageView)
        }
        
        if notFillStar != 0 {
            for _ in 0..<Int(notFillStar) {
                let imageView = UIImageView()
                imageView.image = UIImage(named: "fillStar")
                imageView.tintColor = #colorLiteral(red: 0.9294117647, green: 0.937254902, blue: 0.9450980392, alpha: 1)
                imageView.contentMode = .scaleAspectFit
                starSV.addArrangedSubview(imageView)
                arrImageView.append(imageView)
            }
        }
        
        btnComments.setTitle("Show comments", for: .normal)
        btnComments.titleLabel?.textAlignment = .center
        btnComments.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btnComments.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
              
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 5
        self.addArrangedSubview(lblRating)
        self.addArrangedSubview(starSV)
        self.addArrangedSubview(btnComments)
    }
}
