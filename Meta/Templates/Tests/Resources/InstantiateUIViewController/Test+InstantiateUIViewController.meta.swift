//
//  Test+InstantiateUIViewController.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

// MARK: Processed Types

func getTypesToBeProcessed() -> [Type]
{
    return types.classes
                .filter
                {
                    ($0.inheritedTypes.contains("UIViewController") || $0.inheritedTypes.contains("UITabBarController")) &&
                    !$0.isGeneric &&
                    $0.implements["StoryboardInstantiatable"] != nil
                }
                .sorted(by: { $0.name < $1.name })
}

// MARK: Test Methods

func generateTestMethod(_ type: Type) -> String
{
    return """
func test\(type.name)()
{
    XCTAssertTrue(canBeInstantiated(\(type.name).self))
}
"""
}

// MARK: Test Methods

func generateTestMethods() -> String
{
    return getTypesToBeProcessed()
                .map(generateTestMethod)
                .map(tabulate(1))
                .joined(separator: "\n\n")
}

// MARK: Output

func generateOutput() -> String
{
    return """
import XCTest
@testable import \(projectName)

class InstantiateUIViewControllerTests: XCTestCase
{
    private func canBeInstantiated<ViewController: StoryboardInstantiatable>(_ viewControllerType: ViewController.Type) -> Bool
    {
        return UIViewController.instantiate(storyBoardName:   ViewController.storyboardName.fileName,
                                            viewControllerId: String(describing: ViewController.self)) is ViewController
    }

\(generateTestMethods())
}
"""
}
