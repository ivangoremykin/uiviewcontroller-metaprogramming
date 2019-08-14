// Generated using Sourcery 0.16.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import UIKit

extension UIViewController
{
    var present: UIViewControllerPresent
    {
        return UIViewControllerPresent(self)
    }

    class UIViewControllerPresent
    {
        private weak var viewController: UIViewController?
        
        init(_ viewController: UIViewController)
        {
            self.viewController = viewController
        }

		func autumnViewController(_ everydayRain: Bool, _ leafAmount: LeafAmount, animated: Bool = true)
		{
			viewController?.present(UIViewController.create.autumnViewController(everydayRain, leafAmount), animated: animated, completion: nil)
		}

		func mainViewController(animated: Bool = true)
		{
			viewController?.present(UIViewController.create.mainViewController(), animated: animated, completion: nil)
		}

		func springViewController(_ windSpeed: Float, _ flowerName: String, animated: Bool = true)
		{
			viewController?.present(UIViewController.create.springViewController(windSpeed, flowerName), animated: animated, completion: nil)
		}

		func summerViewController(animated: Bool = true)
		{
			viewController?.present(UIViewController.create.summerViewController(), animated: animated, completion: nil)
		}

		func winterViewController(animated: Bool = true)
		{
			viewController?.present(UIViewController.create.winterViewController(), animated: animated, completion: nil)
		}
    }
}
