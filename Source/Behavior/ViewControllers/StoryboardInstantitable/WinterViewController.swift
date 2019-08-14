//
//  WinterViewController.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

/// Storyboard instantitable. No initialization parameters.
class WinterViewController: UIViewController
{
}

// MARK:- StoryboardInstantitable
extension WinterViewController: StoryboardInstantitable
{
    static var storyboardName: UIStoryboard.Name
    {
        return .storyboardB
    }
}

// MARK:- Lifecycle
extension WinterViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        setupNavigationControls(title: "Winter", animated)
    }
}
