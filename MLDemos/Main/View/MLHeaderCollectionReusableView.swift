//
//  MLHeaderCollectionReusableView.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class MLHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = String(describing: MLHeaderCollectionReusableView.self)
    @IBOutlet weak var titleLabel: UILabel!
}
