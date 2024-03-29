//
//  UIViewController+Create.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

// MARK: Factory Method

func generateFactoryMethod(_ type: Type) -> String
{
    let instantiationKind = getInstantiationKind(type)

    let functionName       = getViewControllerFunctionName(type)
    let functionParameters = generateViewControllerFunctionParameters(type, instantiationKind)
    let functionBody       = generateFunctionBody(type, instantiationKind)

    return """
func \(functionName)(\(functionParameters)) -> \(type.name)
{
\(tabulate(1)(functionBody))
}
"""
}

// MARK: Body

func generateFunctionBody(_ type: Type, _ instantiationKind: UIViewControllerInstantiationKind) -> String
{
    switch instantiationKind
    {
    case .storyboardYES_initializeYES:
        return generateFunctionBody_WithStoryboard_WithInitialize(type)

    case .storyboardYES_initializeNO:
        return generateFunctionBody_WithStoryboard_WithoutInitialize(type)

    case .storyboardNO_initializeYES:
        return generateFunctionBody_WithoutStoryboard_WithInitialize(type)

    case .storyboardNO_initializeNO:
        return generateFunctionBody_WithoutStoryboard_WithoutInitialize(type)
    }
}

// MARK: Body Per Instantiation Kind

func generateFunctionBody_WithStoryboard_WithInitialize(_ type: Type) -> String
{
    return """
let viewController = \(instantiateWithStoryboard(type))

\(passParametersToInitialize(type))

return viewController
"""
}

func generateFunctionBody_WithStoryboard_WithoutInitialize(_ type: Type) -> String
{
    return """
return \(instantiateWithStoryboard(type))
"""
}

func generateFunctionBody_WithoutStoryboard_WithInitialize(_ type: Type) -> String
{
    return """
let viewController = \(instantiateWithoutStoryboard(type))

\(passParametersToInitialize(type))

return viewController
"""
}

func generateFunctionBody_WithoutStoryboard_WithoutInitialize(_ type: Type) -> String
{
    return """
return \(instantiateWithoutStoryboard(type))
"""
}

// MARK: Body Helpers

func instantiateWithStoryboard(_ type: Type) -> String
{
    return "UIViewController.instantiate(\(type.name).self)"
}

func instantiateWithoutStoryboard(_ type: Type) -> String
{
    return "\(type.name)()"
}

func passParametersToInitialize(_ type: Type) -> String
{
    return "viewController.initialize(\(getPassedParameters(type, shouldSkipLabels: false)))"
}

// MARK: Factory Methods

func generateFactoryMethods() -> String
{
    return getTypesToBeProcessed()
              .map(generateFactoryMethod)
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
    static let create = UIViewControllerCreate()

    class UIViewControllerCreate
    {
\(generateFactoryMethods())
    }
}
"""
}
