// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


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

		func autumnViewController(_ everydayRain: Bool, _ leafAmount: LeafAmount, animated: Bool = true)
		{
			navigationController?.pushViewController(UIViewController.create.autumnViewController(everydayRain, leafAmount), animated: animated)
		}

		func mainViewController(animated: Bool = true)
		{
			navigationController?.pushViewController(UIViewController.create.mainViewController(), animated: animated)
		}

		func springViewController(_ windSpeed: Float, _ flowerName: String, animated: Bool = true)
		{
			navigationController?.pushViewController(UIViewController.create.springViewController(windSpeed, flowerName), animated: animated)
		}

		func summerViewController(animated: Bool = true)
		{
			navigationController?.pushViewController(UIViewController.create.summerViewController(), animated: animated)
		}

		func winterViewController(animated: Bool = true)
		{
			navigationController?.pushViewController(UIViewController.create.winterViewController(), animated: animated)
		}
    }
}
