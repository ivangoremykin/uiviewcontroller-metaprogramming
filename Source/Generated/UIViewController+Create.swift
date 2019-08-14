// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import UIKit

extension UIViewController
{
    static let create = UIViewControllerCreate()

    class UIViewControllerCreate
    {
		func autumnViewController(_ everydayRain: Bool, _ leafAmount: LeafAmount) -> AutumnViewController
		{
			let viewController = UIViewController.instantiate(AutumnViewController.self)
			
			viewController.initialize(everydayRain: everydayRain, leafAmount: leafAmount)
			
			return viewController
		}

		func mainViewController() -> MainViewController
		{
			return UIViewController.instantiate(MainViewController.self)
		}

		func springViewController(_ windSpeed: Float, _ flowerName: String) -> SpringViewController
		{
			let viewController = SpringViewController()
			
			viewController.initialize(windSpeed: windSpeed, flowerName: flowerName)
			
			return viewController
		}

		func summerViewController() -> SummerViewController
		{
			return SummerViewController()
		}

		func winterViewController() -> WinterViewController
		{
			return UIViewController.instantiate(WinterViewController.self)
		}
    }
}
