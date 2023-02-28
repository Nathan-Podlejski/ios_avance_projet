//
//  ViewController.swift
//  IOS avance projet
//
//  Created by lpiem on 01/02/2023.
//

import UIKit

class ViewController: UICollectionViewController {

    enum Section {
        case featured
        case lists
    }
    
    enum Item: Hashable {
        case featured(Landmark)
        case notFeatured(Landmark)
    }
    
    private var landmarks: [Landmark] = Service.shared.loadLandmarks()
        
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = createLayout()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            switch itemIdentifier {
            case .featured(let landmark), .notFeatured(let landmark) :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
                 
                cell.img.image = landmark.image
                cell.lblTitre.text = landmark.name

                return cell
            }
        })
        
        
        let snapshot = createSnapshot()
        dataSource.apply(snapshot)
        
        
    }
    
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.featured, .lists])
        
        let colorItems = landmarks.filter{$0.isFeatured == true}.map(Item.featured)
        snapshot.appendItems(colorItems, toSection: .featured)
        
        let smallColorItems = landmarks.map(Item.notFeatured)
        snapshot.appendItems(smallColorItems, toSection: .lists)
        
        
        return snapshot
    }

    private func createLayout () -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, collectionLayoutEnvironment -> NSCollectionLayoutSection? in
            
            guard let self = self,
                  let section = self.dataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
                        
            switch section {
            case .featured :
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let containerGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.4)),
                    subitems: [item])
                
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.orthogonalScrollingBehavior = .groupPaging
            
                return section

                
            case .lists:

                var itemSize: NSCollectionLayoutSize
                if (collectionLayoutEnvironment.traitCollection.horizontalSizeClass.rawValue == 2 && collectionLayoutEnvironment.traitCollection.verticalSizeClass.rawValue == 2) {
                    itemSize  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                       heightDimension: .fractionalHeight(0.5))
                } else {
                    itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                         heightDimension: .fractionalHeight(1.0))
                }
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                                       heightDimension: .fractionalWidth(0.6))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 0
                

                return section
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        layout.configuration = config
        return layout
    }

}

