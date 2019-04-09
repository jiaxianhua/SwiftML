//
//  MLCollection.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

struct MLItem {
    var image: UIImage
    var title: String
}

struct MLSection {
    var title: String
    var items: [MLItem]
}

struct MLCollections {
    var title: String
    var sections: [MLSection]
}
