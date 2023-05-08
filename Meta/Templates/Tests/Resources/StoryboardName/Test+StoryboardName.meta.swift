//
//  Test+StoryboardName.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

// MARK: Test Method

func generateTestMethod(_ enumCase: EnumCase) -> String
{
    return """
func test\(enumCase.name.uppercasedFirstLetter())()
{
    XCTAssertNotNil(getPath(for: .\(enumCase.name)))
}
"""
}

// MARK: Test Methods

func generateTestMethods() -> String
{
    return types.enums
              .first(where: { $0.name == "UIStoryboard.Name" })?
              .cases
              .map(generateTestMethod)
              .map(tabulate(1))
              .joined(separator: "\n\n") ?? ""
}

// MARK: Output

func generateOutput() -> String
{
    return """
import XCTest
@testable import \(projectName)

class StoryboardNameTests: XCTestCase
{
    private func getPath(for storyboardName: UIStoryboard.Name) -> String?
    {
        return Bundle.main.path(forResource: storyboardName.fileName, ofType: "storyboardc")
    }

\(generateTestMethods())
}
"""
}
