// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import UIViewControllerMetaprogramming

class StoryboardNameTests: XCTestCase
{
    private func getPath(for storyboardName: UIStoryboard.Name) -> String?
    {
        return Bundle.main.path(forResource: storyboardName.fileName, ofType: "storyboardc")
    }

	func testMain()
	{
		XCTAssertNotNil(getPath(for: .main))
	}

	func testStoryboardA()
	{
		XCTAssertNotNil(getPath(for: .storyboardA))
	}

	func testStoryboardB()
	{
		XCTAssertNotNil(getPath(for: .storyboardB))
	}
}
