//
//  UITextField+InputAccessoryView.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 31/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UITextField
{
    func setDoneToolbarAsInputAccessoryView()
    {
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton  = UIBarButtonItem(title: "Done",
                                          style: .plain,
                                          target: self,
                                          action: #selector(UITextField.resignFirstResponder))
        
        self.inputAccessoryView = createToolbar([spaceButton, doneButton])
    }
    
    private func createToolbar(_ barButtonItems: [UIBarButtonItem]) -> UIToolbar
    {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = tintColor
        toolBar.sizeToFit()
        toolBar.setItems(barButtonItems, animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
