//
//  StoryboardName.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UIStoryboard
{
    enum Name: String
    {
        case main
        case storyboardA
        case storyboardB
        
        var fileName: String
        {
            return rawValue.uppercasedFirstLetter()
        }
    }
}
