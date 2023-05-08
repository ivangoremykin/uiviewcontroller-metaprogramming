//
//  UIViewController+Common.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

func getTypesToBeProcessed() -> [Type]
{
    return types.classes
            .filter { ($0.inheritedTypes.contains("UIViewController") || $0.inheritedTypes.contains("UITabBarController")) && !$0.isGeneric }
            .sorted(by: { $0.name < $1.name })
}

func getViewControllerFunctionName(_ type: Type) -> String
{
    return type.name.lowercasedFirstLetter()
}

enum UIViewControllerInstantiationKind
{
    case storyboardYES_initializeYES
    case storyboardYES_initializeNO
    case storyboardNO_initializeYES
    case storyboardNO_initializeNO
}

func getInstantiationKind(_ type: Type) -> UIViewControllerInstantiationKind
{
    let typeImplementsStoryboardInstantitable = type.implements["StoryboardInstantiatable"] != nil
    let typeHasInitializeMethod = type.hasMethod(named: "initialize")

    if typeImplementsStoryboardInstantitable
    {
        if typeHasInitializeMethod
        {
            return .storyboardYES_initializeYES
        }
        else
        {
            return .storyboardYES_initializeNO
        }
    }
    else
    {
        if typeHasInitializeMethod
        {
            return .storyboardNO_initializeYES
        }
        else
        {
            return .storyboardNO_initializeNO
        }
    }
}

func generateNavigationFunctionParameters(_ type: Type, _ instantiationKind: UIViewControllerInstantiationKind) -> String
{
    let viewControllerFunctionParameters = generateViewControllerFunctionParameters(type, instantiationKind)

    return viewControllerFunctionParameters
                + (viewControllerFunctionParameters.isEmpty ? "" : ", ")
                + "animated: Bool = true"
}

func generateViewControllerFunctionParameters(_ type: Type, _ instantiationKind: UIViewControllerInstantiationKind) -> String
{
    switch instantiationKind
    {
    case .storyboardYES_initializeYES, .storyboardNO_initializeYES:
        return getInitializeParameters(type)

    case .storyboardYES_initializeNO, .storyboardNO_initializeNO:
        return ""
    }
}

func getInitializeParameters(_ type: Type) -> String
{
    return getInitializeMethod(type).parameters
                .map
                {
                    "_ \($0.name): \($0.typeName.name)"
                }
                .joined(separator: ", ")
}

func getInitializeMethod(_ type: Type) -> SourceryMethod!
{
    return type.getMethods(named: "initialize").first
}

func getPassedParameters(_ type: Type, shouldSkipLabels: Bool) -> String
{
    if let initializeMethod = getInitializeMethod(type)
    {
        return initializeMethod.parameters
                    .map
                    {
                        let argumentLabelPrefix = ($0.argumentLabel == nil || shouldSkipLabels)
                                                        ? ""
                                                        : "\($0.argumentLabel!): "

                        return argumentLabelPrefix + "\($0.name)"
                    }
                    .joined(separator: ", ")
    }
    else
    {
        return ""
    }
}

func generateCreateViewControllerCall(_ type: Type) -> String
{
    return "UIViewController.create.\(getViewControllerFunctionName(type))(\(getPassedParameters(type, shouldSkipLabels: true)))"
}
