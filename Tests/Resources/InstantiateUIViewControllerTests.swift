// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import XCTest
@testable import UIViewControllerMetaprogramming

class InstantiateUIViewControllerTests: XCTestCase
{
    private func canBeInstantiated<ViewController: StoryboardInstantitable>(_ viewControllerType: ViewController.Type) -> Bool
    {
        return UIViewController.instantiate(storyBoardName:   ViewController.storyboardName.fileName,
                                            viewControllerId: String(describing: ViewController.self)) is ViewController
    }

	func testAutumnViewController()
	{
	    XCTAssertTrue(canBeInstantiated(AutumnViewController.self))
	}

	func testMainViewController()
	{
	    XCTAssertTrue(canBeInstantiated(MainViewController.self))
	}

	func testWinterViewController()
	{
	    XCTAssertTrue(canBeInstantiated(WinterViewController.self))
	}
}
