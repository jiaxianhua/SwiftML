//
//  Enums.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import Foundation

enum MLStep: Int {
    case train
    case predict
}

enum GeometryType: Int  {
    case box
    case pyramid
    case sphere
    case cylinder
    case cone
    case tube
    case torus
    
    case circle
    case triangle
    case flower
    case __totalCount
    
    static func numberOfCases() -> Int {
        return GeometryType.__totalCount.rawValue
    }
}

extension GeometryType: CustomStringConvertible {
    var description: String {
        switch self {
        case .box:
            return "box"
        case .pyramid:
            return "pyramid"
        case .sphere:
            return "sphere"
        case .cylinder:
            return "cylinder"
        case .cone:
            return "cone"
        case .tube:
            return "tube"
        case .torus:
            return "torus"
        case .circle:
            return "circle"
        case .triangle:
            return "triangle"
        case .flower:
            return "flower"
        case .__totalCount:
            fatalError()
        }
    }
}
