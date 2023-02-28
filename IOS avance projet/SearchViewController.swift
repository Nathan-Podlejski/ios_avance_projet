//
//  SearchViewController.swift
//  IOS avance projet
//
//  Created by lpiem on 28/02/2023.
//

import UIKit

class SearchViewController: UITableViewController {
    
    enum Section {
        case main
    }
    
    enum Item: Hashable{
        case text(String)
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        
    }

}
