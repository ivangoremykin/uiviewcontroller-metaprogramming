//
//  UIViewControllerInstantiation.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UIViewController
{
    static func instantiate(storyBoardName: String, viewControllerId: String) -> UIViewController
    {
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: viewControllerId)
    }
    
    static func instantiate<ViewController: StoryboardInstantiatable>(_ viewControllerType: ViewController.Type) -> ViewController
    {
        return instantiate(storyBoardName: ViewController.storyboardName.fileName,
                           viewControllerId: String(describing: ViewController.self)) as! ViewController
    }
}
