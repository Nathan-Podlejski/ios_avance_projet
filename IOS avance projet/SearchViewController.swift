//
//  SearchViewController.swift
//  IOS avance projet
//
//  Created by lpiem on 28/02/2023.
//

import UIKit

class SearchViewController: UITableViewController {
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    
    enum Section {
        case main
    }
    
    enum Item: Hashable{
        case text(String)
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    private var landmarks: [Landmark] = Service.shared.loadLandmarks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: {tableView, indexPath, itemIdentifier in
            switch itemIdentifier{
            case .text(let value):
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                var content = cell.defaultContentConfiguration()
                content.text = value
                cell.contentConfiguration = content
                
                return cell
            }
        })
        
        let snapshot = createSnapshot(landmarks: landmarks)
        dataSource.apply(snapshot)

    }
    
    private func createSnapshot(landmarks: [Landmark]) -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        let items = landmarks.map { element in
            Item.text(element.name)
        }
        
        snapshot.appendItems(items, toSection: .main)
        
        return snapshot
    }
    
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "detailSegue") {
            let navVC = segue.destination as! UINavigationController
            let destView = navVC.topViewController as! DetailViewController
            destView.landmark = landmarks[tableView.indexPath(for: sender as! UITableViewCell)!.row]
        }
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.isEmpty == false else {
            let snapshot = createSnapshot(landmarks: landmarks)
            dataSource.apply(snapshot)
            return
        }
        
        let filteredNames = landmarks.filter { item in
            item.name.localizedCaseInsensitiveContains(searchText)
        }
        let snapshot = createSnapshot(landmarks: filteredNames)
        dataSource.apply(snapshot)
    }
}
