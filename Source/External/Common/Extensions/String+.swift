//
//  String+.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import Foundation

extension String
{
    func uppercasedFirstLetter() -> String
    {
        return isEmpty ? "" : prefix(1).uppercased() + dropFirst()
    }
    
    func lowercasedFirstLetter() -> String
    {
        return isEmpty ? "" : prefix(1).lowercased() + dropFirst()
    }
}
