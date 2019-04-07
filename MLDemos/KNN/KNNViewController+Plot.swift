//
//  KNNViewController+Plot.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

extension KNNViewController {
    fileprivate func flowerLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let width: CGFloat = radius
        let height: CGFloat = width

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: position.x, y: position.y,
            width: width, height: height)

        let path = CGMutablePath()

        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 3).forEach {
            angle in
            var transform = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))

            let petal = CGPath(ellipseIn: CGRect(x: -width, y: 0, width: width, height: height),
                transform: &transform)

            path.addPath(petal)
        }

        shapeLayer.path = path
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shapeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: alpha).cgColor

        panelView.layer.addSublayer(shapeLayer)
    }

    fileprivate func circleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2), cornerRadius: radius).cgPath
        shapeLayer.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: alpha).cgColor
        panelView.layer.addSublayer(shapeLayer)
    }

    fileprivate func rectangleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(rect: CGRect(x: position.x - radius, y: position.y - radius, width: radius * 2, height: radius * 2)).cgPath
        shapeLayer.fillColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: alpha).cgColor
        panelView.layer.addSublayer(shapeLayer)
        predictLayers.append(shapeLayer)
    }

    fileprivate func triangleLayer(_ position: CGPoint, alpha: CGFloat = 1) {
        let layer = CALayer()
        layer.position = position
        layer.contents = UIImage(named: "triangle")?.image(alpha: alpha)?.cgImage
        layer.contentsGravity = CALayerContentsGravity.center

        panelView.layer.addSublayer(layer)
    }

    func drawIn(_ position: CGPoint, geometryType: GeometryType) {
        switch mlStep {
        case .train:
            let trainx = [Double(position.x), Double(position.y)]
            X.append(trainx)
            y.append(geometryType)

            switch geometryType {
            case .box:
                circleLayer(position)
                break
            case .pyramid:
                triangleLayer(position)
                break
            case .sphere:
                flowerLayer(position)
            default:
                break
            }

            break
        case .predict:
            XTest.append([Double(position.x), Double(position.y)])

            rectangleLayer(position)
            break
        }
    }

    func drawPredict() {
        if let subLayers = panelView.layer.sublayers {
            for layer in subLayers {
                if predictLayers.contains(layer) {
                    layer.removeFromSuperlayer()
                }
            }
        }

        predictLayers.removeAll()

        _ = zip(XTest, yTest).map({ (sample_X, sample_y) in
            let position = CGPoint(x: sample_X.first!, y: sample_X.last!)
            let geometryType = sample_y

            switch geometryType {
            case .box:
                circleLayer(position, alpha: 0.2)
                break
            case .pyramid:
                triangleLayer(position, alpha: 0.2)
                break
            case .sphere:
                flowerLayer(position, alpha: 0.2)
            default:
                break
            }
        })
    }

    func drawCircle(center: CGPoint, radius: CGFloat, alpha: CGFloat = 0.1) {
        let r = self.radius + radius
        let kNNCircleLayer = CAShapeLayer()
        kNNCircleLayer.path = UIBezierPath(roundedRect: CGRect(x: center.x - r, y: center.y - r, width: r * 2, height: r * 2), cornerRadius: r).cgPath
        kNNCircleLayer.fillColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: alpha).cgColor
        kNNCircleLayer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
        kNNCircleLayer.borderWidth = 1
        panelView.layer.addSublayer(kNNCircleLayer)
    }
}

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
