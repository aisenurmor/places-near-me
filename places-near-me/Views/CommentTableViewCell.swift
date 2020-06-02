//
//  CommentTableViewCell.swift
//  places-near-me
//
//  Created by aisenur on 30.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.separatorInset = .zero
        
        userImageView.layer.cornerRadius = 75/2
        userImageView.clipsToBounds = true
        userImageView.layer.borderWidth = 3
        userImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
