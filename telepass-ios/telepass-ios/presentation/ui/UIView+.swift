//
//  UIView+.swift
//  telepass-ios
//
//  Created by Luca Pavan on 12/11/21.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func elevate(elevation: Double) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: elevation)
        layer.shadowRadius = CGFloat(elevation)
        layer.shadowOpacity = 0.24
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
