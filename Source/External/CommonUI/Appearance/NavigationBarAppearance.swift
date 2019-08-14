//
//  NavigationBarAppearance.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 24/07/2019.
//  Copyright © 2019 Ivan Goremykin, Dmitry Cherednikov. All rights reserved.
//

import UIKit

enum NavigationBarAppearance
{
    case noNavigationBar
    
    case navigationBar(NavigationBarBackgroundAppearance, LeftNavigationBarItem, NavigationBarTitleAppearance, RightNavigationBarItem)
}

enum LeftNavigationBarItem
{
    case noItem
    case defaultBackButton(hasText: Bool)
    
    case customBackButton(UIImage, UIColor?, hasText: Bool)
    case customButton(ButtonAppearance, Selector)
}

enum ButtonAppearance
{
    case text(String, TextAppearance?)
    case image(UIImage, UIColor?)
}

enum NavigationBarTitleAppearance
{
    case noTitle
    
    case text(String, TextAppearance?)
    case image(UIImage)
}

enum RightNavigationBarItem
{
    case noItem
    
    case button(ButtonAppearance, Selector)
    case view(UIView, Selector)
    case customView(UIView)
}

struct TextAppearance
{
    let tintColor: UIColor?
    let font:      UIFont?
}

enum NavigationBarBackgroundAppearance
{
    case transparent(tintColor:    UIColor?,
        barTintColor: UIColor?)
    
    case custom(backgroundImage: UIImage?,
        color:           UIColor?,
        tintColor:       UIColor?,
        shadowImage:     UIImage?)
}

extension UIViewController
{
    func setupNavigationBarAppearance(_ navigationBarAppearance: NavigationBarAppearance, _ animated: Bool)
    {
        switch navigationBarAppearance
        {
        case .noNavigationBar:
            navigationController!.setNavigationBarHidden(true, animated: animated)
            
        case .navigationBar(let backgroundAppearance, let leftItem, let titleAppearance, let rightItem):
            navigationController!.setNavigationBarHidden(false, animated: animated)
            setupNavigationBarAppearance(backgroundAppearance: backgroundAppearance,
                                         leftItem:             leftItem,
                                         titleAppearance:      titleAppearance,
                                         rigthItem:            rightItem,
                                         animated:             animated)
        }
    }
    
    private func setupNavigationBarAppearance(backgroundAppearance: NavigationBarBackgroundAppearance,
                                              leftItem:             LeftNavigationBarItem,
                                              titleAppearance:      NavigationBarTitleAppearance,
                                              rigthItem:            RightNavigationBarItem,
                                              animated:             Bool)
    {
        navigationController!.navigationBar.setupBackgroundAppearance(backgroundAppearance)
        
        setupLeftItem(leftItem, animated: animated)
        setupTitle(titleAppearance)
        setupRightItem(rigthItem, animated: animated)
    }
}

// MARK:- Title
private extension UIViewController
{
    private func setupTitle(_ titleAppearance: NavigationBarTitleAppearance)
    {
        switch titleAppearance
        {
        case .noTitle:
            navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
            
        case .image(let image):
            navigationItem.titleView = UIImageView(image: image)
            
        case .text(let text, let textAppearance):
            setupTitle(text: text, textAppearance: textAppearance)
        }
    }
    
    private func setupTitle(text: String, textAppearance: TextAppearance?)
    {
        navigationItem.title = text
        
        if let tintColor = textAppearance?.tintColor
        {
            navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor]
        }
        else
        {
            navigationController!.navigationBar.titleTextAttributes?.removeValue(forKey: NSAttributedString.Key.foregroundColor)
        }
        
        if let font = textAppearance?.font
        {
            if navigationController!.navigationBar.titleTextAttributes == nil
            {
                navigationController!.navigationBar.titleTextAttributes  = [NSAttributedString.Key.font: font]
            }
            else
            {
                navigationController!.navigationBar.titleTextAttributes![NSAttributedString.Key.font] = font
            }
        }
        else
        {
            navigationController!.navigationBar.titleTextAttributes?.removeValue(forKey: NSAttributedString.Key.font)
        }
    }
}

// MARK:- Left Item
private extension UIViewController
{
    func setupLeftItem(_ leftItem: LeftNavigationBarItem, animated: Bool)
    {
        switch leftItem
        {
        case .noItem:
            removeLeftItemsAndBackButton(animated: animated)
            
        case .defaultBackButton(let hasText):
            setupDefaultBackButton(hasText: hasText, animated: animated)
            
        case .customBackButton(let image, let color, let hasText):
            setupCustomBackButton(image: image, color: color, hasText: hasText, animated: animated)
            
        case .customButton(let appearance, let callback):
            setupLeftItemAndHideBackButton(appearance: appearance, callback: callback, animated: animated)
        }
    }
    
    private func removeLeftItemsAndBackButton(animated: Bool)
    {
        navigationItem.leftBarButtonItems = nil
        navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    // There is no way to restore default appearance if custom back appearance has been set up.
    private func setupDefaultBackButton(hasText: Bool, animated: Bool)
    {
        navigationItem.leftBarButtonItems = nil
        navigationItem.setHidesBackButton(false, animated: animated)
        
        // we can't restore back button image here!!!
        
        if hasText
        {
            navigationController!.navigationBar.topItem?.backBarButtonItem = nil
        }
        else
        {
            navigationController!.navigationBar.topItem?.backBarButtonItem      = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationController!.navigationBar.items?.first?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) // fixes the case when the previous View Controller hides Navigation Bar
        }
    }
    
    private func setupCustomBackButton(image: UIImage, color: UIColor?, hasText: Bool, animated: Bool)
    {
        navigationItem.leftBarButtonItems = nil
        navigationItem.setHidesBackButton(false, animated: animated)
        
        navigationController!.navigationBar.setBackButtonImage(image)
        navigationController!.navigationBar.topItem?.backBarButtonItem?.tintColor = color
    }
    
    private func setupLeftItemAndHideBackButton(appearance: ButtonAppearance, callback: Selector, animated: Bool)
    {
        navigationItem.setHidesBackButton(true, animated: animated)
        
        switch appearance
        {
        case .image(let image, let color):
            navigationItem.leftBarButtonItem = createBarButtonItem(image: image, color: color, target: self, action: callback)
            
        case .text(let text, let textAppearance):
            navigationItem.leftBarButtonItem = createBarButtonItem(text: text, textAppearance: textAppearance, target: self, action: callback)
        }
    }
}

// MARK:- Right
private extension UIViewController
{
    func setupRightItem(_ rightItem: RightNavigationBarItem, animated: Bool)
    {
        switch rightItem
        {
        case .noItem:
            navigationItem.rightBarButtonItems = nil
            
        case .button(let appearance, let callback):
            setupRightItem(appearance: appearance, callback: callback)
            
        case .view(let view, let callback):
            setupRightItem(view: view, callback: callback)
            
        case .customView(let view):
            setupRightItem(view: view)
        }
    }
    
    private func setupRightItem(appearance: ButtonAppearance, callback: Selector)
    {
        switch appearance
        {
        case .image(let image, let color):
            navigationItem.rightBarButtonItem = createBarButtonItem(image: image, color: color, target: self, action: callback)
            
        case .text(let text, let textAppearance):
            navigationItem.rightBarButtonItem = createBarButtonItem(text: text, textAppearance: textAppearance, target: self, action: callback)
        }
    }
    
    private func setupRightItem(view: UIView, callback: Selector)
    {
        navigationItem.rightBarButtonItem = createBarButtonItem(view: view, target: self, action: callback)
    }
    
    private func setupRightItem(view: UIView)
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
}

// MARK:- Bar Button Items
private func createBarButtonItem(image: UIImage, color: UIColor?, target: AnyObject?, action: Selector?) -> UIBarButtonItem
{
    let colorAdjustedImage = (color == nil) ? image.withRenderingMode(.alwaysOriginal) : image.withRenderingMode(.alwaysTemplate)
    
    let item = UIBarButtonItem(image: colorAdjustedImage, style: .plain, target: target, action: action)
    
    item.tintColor = color
    
    return item
}

private func createBarButtonItem(text: String, textAppearance: TextAppearance?, target: AnyObject?, action: Selector?) -> UIBarButtonItem
{
    let item = UIBarButtonItem(title: text, style: .plain, target: target, action: action)
    item.tintColor = textAppearance?.tintColor
    
    if let font = textAppearance?.font
    {
        item.setTitleTextAttributes([NSAttributedString.Key.font : font], for: .normal)
    }
    
    return item
}

private func createBarButtonItem(view: UIView, target: AnyObject?, action: Selector?) -> UIBarButtonItem
{
    let item = UIBarButtonItem(customView: view)
    
    item.target = target
    item.action = action
    
    return item
}

// MARK:- UINavigationBar
private extension UINavigationBar
{
    func setupBackgroundAppearance(_ backgroundAppearance: NavigationBarBackgroundAppearance)
    {
        switch backgroundAppearance
        {
        case .transparent(let tintColor, let barTintColor):
            self.setBackgroundImage(UIImage(), for: .default)
            
            self.shadowImage     = UIImage()
            self.tintColor       = tintColor
            self.barTintColor    = barTintColor
            self.backgroundColor = .clear
            
            self.isTranslucent   = true
            
        case .custom(let backgroundImage, let color, let tintColor, let shadowImage):
            self.setBackgroundImage(backgroundImage, for: .default)
            
            self.shadowImage     = shadowImage
            self.tintColor       = tintColor
            self.barTintColor    = color
            self.backgroundColor = color
            
            self.isTranslucent   = color == .clear
        }
    }
    
    func setBackButtonImage(_ image: UIImage?)
    {
        backIndicatorImage               = image
        backIndicatorTransitionMaskImage = image
    }
}
