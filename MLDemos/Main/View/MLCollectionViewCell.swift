//
//  MLCollectionViewCell.swift
//  MLDemos
//
//  Created by developer on 4/9/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

class MLCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MLCollectionViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snopshotImageView: UIImageView!
    @IBOutlet weak var arImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        arImageView.isHidden = true
    }
}

@IBDesignable
extension MLCollectionViewCell {
    @IBInspectable var borderColor: UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor.init(cgColor: self.layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        borderColor = UIColor.black
        borderWidth = 1.0
        cornerRadius = 3.0
    }
}

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        
        return nil
    }
}
