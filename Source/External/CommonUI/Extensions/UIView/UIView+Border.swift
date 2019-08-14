//
//  UIViewAppearance.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 12/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UIView
{
    func setBorder(cornerRadius: CGFloat, color: UIColor, width: CGFloat)
    {
        layer.cornerRadius  = cornerRadius
        layer.borderColor   = color.cgColor
        layer.borderWidth   = width
        layer.masksToBounds = true
    }
}
