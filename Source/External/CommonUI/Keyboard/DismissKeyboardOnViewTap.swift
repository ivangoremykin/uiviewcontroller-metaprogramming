//
//  DismissKeyboardOnViewTap.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 25/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UIViewController
{
    func dismissKeyboardOnViewTap()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(UIViewController.dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
