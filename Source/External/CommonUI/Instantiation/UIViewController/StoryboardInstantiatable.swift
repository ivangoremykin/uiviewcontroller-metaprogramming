//
//  StoryboardInstantiatable.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable: UIViewController
{
    static var storyboardName: UIStoryboard.Name { get }
}
