//
//  MainViewController+CollectionView.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import ARKit

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mlCollections.sections[section].items.count * 2
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mlCollections.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MLCollectionViewCell.identifier, for: indexPath) as! MLCollectionViewCell

        let item = mlCollections.sections[indexPath.section].items[indexPath.row / 2]

        if indexPath.row % 2 == 0 {
            cell.arImageView.isHidden = true
            cell.titleLabel.text = item.title
        } else {
            var image = UIImage(named: "AR")!

            if !ARConfiguration.isSupported {
                image = image.noir!
            }

            cell.titleLabel.text = item.title + " (AR)"
            cell.arImageView.image = image
            cell.arImageView.isHidden = false
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MLHeaderCollectionReusableView.identifier, for: indexPath) as! MLHeaderCollectionReusableView
            cell.titleLabel.text = mlCollections.sections[indexPath.section].title
            return cell
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mlCollections.sections[indexPath.section].items[indexPath.item]

        if indexPath.item % 2 == 0 {
            performSegue(withIdentifier: item.segue, sender: nil)
        } else {
            guard ARConfiguration.isSupported else {
                return
            }
            performSegue(withIdentifier: "AR\(item.segue)", sender: nil)
        }

    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 10 * 3) / 2
        return CGSize(width: width, height: width + 40)
    }
}
