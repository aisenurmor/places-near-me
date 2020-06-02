//
//  CommentsViewController.swift
//  places-near-me
//
//  Created by aisenur on 30.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    var comments = [Review]() {
        didSet {
            tableView.reloadData()
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentTableViewCell
        let comment = comments[indexPath.row]
        
        cell.userImageView.af.setImage(withURL: comment.user.imageUrl)
        cell.lblUsername.text = comment.user.name
        cell.lblScore.text = String(comment.rating)
        cell.lblComment.text = comment.text
        
        return cell
    }
}
