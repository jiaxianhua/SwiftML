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

enum Geometry2DType: Int  {
    case circle
    case square
    case triangle
    case __totalCount
    
    static func numberOfCases() -> Int {
        return Geometry2DType.__totalCount.rawValue
    }
}

enum Geometry3DType: Int  {
    case box
    case pyramid
    case sphere
    case cylinder
    case cone
    case tube
    case torus
    case __totalCount
    
    static func numberOfCases() -> Int {
        return Geometry3DType.__totalCount.rawValue
    }
}

extension Geometry2DType: CustomStringConvertible {
    var description: String {
        switch self {
        case .circle:
            return "circle"
        case .square:
            return "flower"
        case .triangle:
            return "triangle"
        case .__totalCount:
            fatalError()
        }
    }
}

extension Geometry3DType: CustomStringConvertible {
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
        case .__totalCount:
            fatalError()
        }
    }
}
