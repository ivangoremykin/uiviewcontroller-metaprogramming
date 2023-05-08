//
//  NavigationBarAppearance.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 11/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

// MARK: - Navigation Controls
extension UIViewController
{
    func setupNavigationControls(title: String, _ animated: Bool)
    {
        if isBeingPresented
        {
            setupDismissButton()
        }
        else
        {
            setupNavigationBar(title: title, animated)
        }
    }
}

// MARK: - Dismiss
private extension UIViewController
{
    func setupDismissButton()
    {
        if !hasDismissButton
        {
            addDismissButton()
        }
    }
    
    private func addDismissButton()
    {
        let button = DismissButton(frame: CGRect.zero)
        
        // Appearance
        button.setTitle("Dismiss ↓", for: .normal)
        button.setTitleColor(view.tintColor, for: .normal)
        button.setBorder(cornerRadius: 4, color: button.currentTitleColor, width: 1)
        
        // Interaction
        button.addTarget(self, action: #selector(onDismissButton), for: .touchUpInside)
        
        // Add to scene
        view.addSubview(button)
        
        // Size
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.sizeToFit()
        
        // Position
        let guide = self.view.safeAreaLayoutGuide
        button.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
    }
    
    @objc func onDismissButton(sender: UIButton!)
    {
        dismiss(animated: true)
    }
    
    var hasDismissButton: Bool
    {
        return view.subviews.contains(where: { $0 is DismissButton })
    }
    
    class DismissButton: UIButton
    {
    }
}

// MARK: - Navigation Bar
extension UIViewController
{
    func setupNoNavigationBar(_ animated: Bool)
    {
        setupNavigationBarAppearance(.noNavigationBar, animated)
    }
    
    fileprivate func setupNavigationBar(title: String, _ animated: Bool)
    {
        let titleTextAppearance = TextAppearance(tintColor: view.tintColor, font: nil)
        let backgroundAppearance = NavigationBarBackgroundAppearance.custom(backgroundImage: nil,
                                                                            color: .white,
                                                                            tintColor: view.tintColor,
                                                                            shadowImage: nil)
        
        setupNavigationBarAppearance(.navigationBar(backgroundAppearance, .defaultBackButton(hasText: true), .text(title, titleTextAppearance), .noItem), animated)
    }
}
