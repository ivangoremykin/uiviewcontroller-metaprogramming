//
//  SummerViewController.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

/// Programmatic. No initialization parameters.
class SummerViewController: UIViewController
{
}

// MARK:- Lifecycle
extension SummerViewController
{
    override func viewDidLoad()
    {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setupNavigationControls(title: "Summer", animated)
    }
}

// MARK:- UI Setup
private extension SummerViewController
{
    func setupUI()
    {
        view.backgroundColor = .white
        
        view.embedSeasonImageView(#imageLiteral(resourceName: "summer"))
    }
}
