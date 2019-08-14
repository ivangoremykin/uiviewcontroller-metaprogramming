//
//  AutumnViewController.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

/// Storyboard instantitable. Has initialization parameters.
class AutumnViewController: UIViewController
{
    // MARK:- Outlets
    @IBOutlet weak var everydayRainLabel: UILabel!
    @IBOutlet weak var leafAmountLabel:   UILabel!
    
    // MARK:- Parameters
    fileprivate var everydayRain: Bool!
    fileprivate var leafAmount: LeafAmount!
}

// MARK:- StoryboardInstantiatable
extension AutumnViewController: StoryboardInstantiatable
{
    static var storyboardName: UIStoryboard.Name
    {
        return .storyboardA
    }
}

// MARK:- Initialization
extension AutumnViewController
{
    func initialize(everydayRain: Bool, leafAmount: LeafAmount)
    {
        self.everydayRain = everydayRain
        self.leafAmount   = leafAmount
    }
}

// MARK:- Lifecycle
extension AutumnViewController
{
    override func viewDidLoad()
    {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setupNavigationControls(title: "Autumn", animated)
    }
}


// MARK:- UI Setup
private extension AutumnViewController
{
    func setupUI()
    {
        everydayRainLabel.text = "Everyday Rain: \(everydayRain ? "Yes" : "No")"
        everydayRainLabel.sizeToFit()
        
        leafAmountLabel.text = "Leaf Amount: \(leafAmount.rawValue)"
        leafAmountLabel.sizeToFit()
    }
}
