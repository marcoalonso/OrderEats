//
//  UIViewExtension.swift
//  OrderEats
//
//  Created by marco rodriguez on 26/07/21.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
