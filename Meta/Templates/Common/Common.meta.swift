//
//  Common.meta.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 08/05/2023.
//  Copyright © 2023 Ivan Goremykin. All rights reserved.
//

import Foundation
import SourceryRuntime

var projectName: String
{
    if let value = argument["projectName"] as? String
    {
        return value
    }

    return "ProjectNameNotSpecified"
}

extension String
{
    func uppercasedFirstLetter() -> String
    {
        return isEmpty ? "" : prefix(1).uppercased() + dropFirst()
    }

    func lowercasedFirstLetter() -> String
    {
        return isEmpty ? "" : prefix(1).lowercased() + dropFirst()
    }
}

extension Type
{
    func hasMethod(named methodName: String) -> Bool
    {
        return methods.first(where: { $0.callName == methodName }) != nil
    }

    func getMethods(named methodName: String) -> [SourceryMethod]
    {
        return methods.filter{ $0.callName == methodName }
    }
}

func tabulate(_ count: Int) -> (String) -> String
{
    return {
        let tabs = String(repeating: "\t", count: count)

        return tabs + $0.replacingOccurrences(of: "\n", with: "\n\(tabs)")
    }
}

func commaSeparated(_ prefix: String, _ totalNumber: Int) -> String
{
    return (0..<totalNumber)
                .enumerated()
                .map { "\(prefix)\($0.0)" }
                .joined(separator: ", ")
}

func templateDeclaration(_ typeName: String, _ totalNumber: Int) -> String
{
    return "<\(commaSeparated(typeName, totalNumber))>"
}

func typeConstraints(_ typeName: String, _ totalNumber: Int, _ constraintName: String) -> String
{
    return (0..<totalNumber)
                .enumerated()
                .map { "\(typeName)\($0.0): \(constraintName)" }
                .joined(separator: ", ")
}

func getRawTypeName(_ variable: Variable) -> String
{
    let typeName = variable.typeName.isArray
                        ? variable.typeName.array!.elementTypeName
                        : variable.typeName

    if let actualTypeName = typeName.actualTypeName
    {
        return actualTypeName.unwrappedTypeName
    }
    else
    {
        return typeName.unwrappedTypeName
    }
}

func extractAssociatedValue(_ string: String, _ parameterName: String) -> String
{
    let start = string.index(string.startIndex, offsetBy: parameterName.count + 1)
    let end   = string.index(string.endIndex, offsetBy: -1)

    return string.substring(with: start..<end)
}
