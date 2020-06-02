//
//  MainViewController.swift
//  places-near-me
//
//  Created by aisenur on 21.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit

protocol PlacesListAction {
    func chosePlace(place: PlaceListViewModel)
}

class MainViewController: UITableViewController {
    
    var delegate: PlacesListAction?
    
    var placeList = [PlaceListViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchField()
        addShadow()
    }
    
    fileprivate func removeItems() {
        let targetView = self.navigationController?.navigationBar
        
        for i in targetView!.subviews {
            i.removeFromSuperview()
        }
    }
    
    fileprivate func addShadow() {
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
    }
    
    fileprivate func addSearchField() {
        navigationItem.largeTitleDisplayMode = .never
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        //navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath) as! PlaceTableViewCell
        let place = placeList[indexPath.row]
        
        cell.setCell(place: place)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeItems()
        delegate?.chosePlace(place: placeList[indexPath.row])
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchPhrase = searchBar.text {
            let appDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
            appDelegate.searchPhrase = searchPhrase
        }
    }
}
