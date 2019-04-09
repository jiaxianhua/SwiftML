//
//  MainViewController.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let mlCollections = MLCollections(title: "Swift ML", sections: [
        MLSection(title: "KNN", items: [
            MLItem(image: UIImage(named: "KNN")!, title: "KNN Classifer")
            ]),
        MLSection(title: "KMeans", items: [
            MLItem(image: UIImage(named: "KNN")!, title: "KMeans Cluster")
            ])
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = mlCollections.title

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.bounds.size.height
            
            layout.itemSize = CGSize(width: width/5, height: width/5)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = collectionView.bounds.size.width
            
            layout.itemSize = CGSize(width: width/5, height: width/5)
            layout.invalidateLayout()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
