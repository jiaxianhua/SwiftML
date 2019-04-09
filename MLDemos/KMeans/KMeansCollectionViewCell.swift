//
//  KMeansCollectionViewCell.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class KMeansCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: KMeansCollectionViewCell.self)

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
            else {
                self.transform = CGAffineTransform.identity
            }
        }
    }

    @IBOutlet weak var imageView: UIImageView!
}
