//
//  SpringViewController.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

/// Programmatic. Has initialization parameters.
class SpringViewController: UIViewController
{
    // MARK: - Parameters
    fileprivate var windSpeed: Float!
    fileprivate var flowerName: String!
}

// MARK: - Initialization
extension SpringViewController
{
    func initialize(windSpeed: Float, flowerName: String)
    {
        self.windSpeed = windSpeed
        self.flowerName = flowerName
    }
}

// MARK: - Constants
extension SpringViewController
{
    struct Constants
    {
        static let margin: CGFloat = 10
        static let labelOffset: CGFloat = 4
    }
}

// MARK: - Lifecycle
extension SpringViewController
{
    override func viewDidLoad()
    {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setupNavigationControls(title: "Spring", animated)
    }
}

// MARK: - UI Setup
private extension SpringViewController
{
    func setupUI()
    {
        view.backgroundColor = .white
        
        addLabels()
        view.embedSeasonImageView(#imageLiteral(resourceName: "spring"))
    }
    
    private func addLabels()
    {
        // Create
        let windSpeedLabel  = createLabel("Wind speed: \(String.localizedStringWithFormat("%.2f", self.windSpeed))")
        let flowerNameLabel = createLabel("Flower name: \(self.flowerName!)")
        
        // Add to scene
        view.addSubview(windSpeedLabel)
        view.addSubview(flowerNameLabel)
        
        // Set size
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.margin).isActive = true
        windSpeedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.margin).isActive = true
        
        flowerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        flowerNameLabel.leadingAnchor.constraint(equalTo: windSpeedLabel.leadingAnchor).isActive = true
        flowerNameLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: Constants.labelOffset).isActive = true
    }
}

// MARK: - Utils
private func createLabel(_ text: String) -> UILabel
{
    let label = UILabel(frame: CGRect.zero)
    
    // Value
    label.text = text
    
    // Size
    label.numberOfLines = 1
    label.sizeToFit()
    
    return label
}
