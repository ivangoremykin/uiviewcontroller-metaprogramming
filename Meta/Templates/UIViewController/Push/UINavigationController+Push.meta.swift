//
//  UINavigationController+Push.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

// MARK: Push Method

func generatePushMethod(_ type: Type) -> String
{
    let instantiationKind = getInstantiationKind(type)

    let functionName       = getViewControllerFunctionName(type)
    let functionParameters = generateNavigationFunctionParameters(type, instantiationKind)
    let functionBody       = generatePushFunctionBody(type)

    return """
func \(functionName)(\(functionParameters))
{
\(tabulate(1)(functionBody))
}
"""
}

// MARK: Body

func generatePushFunctionBody(_ type: Type) -> String
{
    let createViewControllerCall = generateCreateViewControllerCall(type)

    return "navigationController?.pushViewController(\(createViewControllerCall), animated: animated)"
}

// MARK: Push Methods

func generatePushMethods() -> String
{
    return getTypesToBeProcessed()
              .map(generatePushMethod)
              .map(tabulate(2))
              .joined(separator: "\n\n")
}

// MARK: Output

func generateOutput() -> String
{
    return """
import UIKit

extension UINavigationController
{
    var push: UINavigationControllerPush
    {
        return UINavigationControllerPush(self)
    }

    class UINavigationControllerPush
    {
        private weak var navigationController: UINavigationController?
        
        init(_ navigationController: UINavigationController)
        {
            self.navigationController = navigationController
        }

\(generatePushMethods())
    }
}
"""
}
