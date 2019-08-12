//
//  ARKNNViewController+Plot.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/7.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import ARKit

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}

extension ARKNNViewController {
//    红色 #FF0000
//    橙色 #FF7F00
//    黄色 #FFFF00
//    绿色 #00FF00
//    青色 #00FFFF
//    蓝色 #0000FF
//    紫色 #8B00FF
    func createBox() -> SCNNode {
        let geometry = SCNBox(width: radius, height: radius, length: radius, chamferRadius: 0)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#FF0000")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createPyramid() -> SCNNode {
        let geometry = SCNPyramid(width: radius, height: radius, length: radius)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#FF7F00")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createSphere() -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#FFFF00")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createCylinder() -> SCNNode {
        let geometry = SCNCylinder(radius: radius, height: radius)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#00FF00")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createCone() -> SCNNode {
        let geometry = SCNCone(topRadius: radius / 2, bottomRadius: radius, height: radius)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#00FFFF")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createTube() -> SCNNode {
        let geometry = SCNTube(innerRadius: radius / 2, outerRadius: radius, height: radius / 2)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#0000FF")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }

    func createTorus() -> SCNNode {
        let geometry = SCNTorus(ringRadius: radius / 2, pipeRadius: radius)
        geometry.firstMaterial?.diffuse.contents = UIColor(hexString: "#8B00FF")
        let node = SCNNode()
        node.geometry = geometry
        return node
    }
}


