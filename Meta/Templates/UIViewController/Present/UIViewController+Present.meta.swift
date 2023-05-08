//
//  UIViewController+Present.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

// MARK: Present Method

func generatePresentMethod(_ type: Type) -> String
{
    let instantiationKind = getInstantiationKind(type)

    let functionName       = getViewControllerFunctionName(type)
    let functionParameters = generateNavigationFunctionParameters(type, instantiationKind)
    let functionBody       = generatePresentFunctionBody(type)

    return """
func \(functionName)(\(functionParameters))
{
\(tabulate(1)(functionBody))
}
"""
}

// MARK: Body

func generatePresentFunctionBody(_ type: Type) -> String
{
    let createViewControllerCall = generateCreateViewControllerCall(type)

    return "viewController?.present(\(createViewControllerCall), animated: animated, completion: nil)"
}

// MARK: Present Methods

func generatePresentMethods() -> String
{
    return getTypesToBeProcessed()
              .map(generatePresentMethod)
              .map(tabulate(2))
              .joined(separator: "\n\n")
}

// MARK: Output

func generateOutput() -> String
{
    return """
import UIKit

extension UIViewController
{
    var present: UIViewControllerPresent
    {
        return UIViewControllerPresent(self)
    }

    class UIViewControllerPresent
    {
        private weak var viewController: UIViewController?
        
        init(_ viewController: UIViewController)
        {
            self.viewController = viewController
        }

\(generatePresentMethods())
    }
}
"""
}
