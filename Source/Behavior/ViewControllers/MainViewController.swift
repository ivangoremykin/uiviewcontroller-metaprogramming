//
//  ViewController.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 03/07/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    // MARK:- Outlets
    @IBOutlet weak var presentSpringButton: UIButton!
    @IBOutlet weak var pushSpringButton:    UIButton!
    
    @IBOutlet weak var presentSummerButton: UIButton!
    @IBOutlet weak var pushSummerButton:    UIButton!
    
    @IBOutlet weak var presentAutumnButton: UIButton!
    @IBOutlet weak var pushAutumnButton:    UIButton!
    
    @IBOutlet weak var presentWinterButton: UIButton!
    @IBOutlet weak var pushWinterButton:    UIButton!
    
    // Spring
    @IBOutlet weak var windSpeedSlider:     UISlider!
    @IBOutlet weak var flowerNameTextField: UITextField!
    
    // Autumn
    @IBOutlet weak var everydayRainSwitch: UISwitch!
    @IBOutlet weak var fallenLeafAmountTextField: UITextField!
    
    // MARK:- Views
    fileprivate var fallenLeafAmountPickerView: UIPickerView!
    
    // MARK:- State
    fileprivate var selectedFallenLeafAmountIndex: Int = 1
}

// MARK:- StoryboardInstantiatable
extension MainViewController: StoryboardInstantiatable
{
    static var storyboardName: UIStoryboard.Name
    {
        return .main
    }
}

// MARK:- Constants
extension MainViewController
{
    struct Constants
    {
        static let buttonBorderWidth:  CGFloat = 1
        static let buttonCornerRadius: CGFloat = 4
    }
}

// MARK:- Lifecycle
extension MainViewController
{
    override func viewDidLoad()
    {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        setupNoNavigationBar(animated)
    }
}

// MARK:- UI Handlers
private extension MainViewController
{
    // MARK: Spring
    @IBAction func onPresentSpringButton()
    {
        present.springViewController(windSpeedSlider.value, flowerNameTextField.text!)
    }
    
    @IBAction func onPushSpringButton()
    {
        navigationController?.push.springViewController(windSpeedSlider.value, flowerNameTextField.text!)
    }
    
    // MARK: Summer
    @IBAction func onPresentSummerButton()
    {
        present.summerViewController()
    }
    
    @IBAction func onPushSummerButton()
    {
        navigationController?.push.summerViewController()
    }
    
    // MARK: Autumn
    @IBAction func onPresentAutumnButton()
    {
        present.autumnViewController(everydayRainSwitch.isOn, LeafAmount.allCases[selectedFallenLeafAmountIndex])
    }
    
    @IBAction func onPushAutumnButton()
    {
        navigationController?.push.autumnViewController(everydayRainSwitch.isOn, LeafAmount.allCases[selectedFallenLeafAmountIndex])
    }
    
    // MARK: Winter
    @IBAction func onPresentWinterButton()
    {
        present.winterViewController()
    }
    
    @IBAction func onPushWinterButton()
    {
        navigationController?.push.winterViewController()
    }
}

// MARK:- UI Setup
private extension MainViewController
{
    func setupUI()
    {
        dismissKeyboardOnViewTap()
        
        setupPushPresentButtons()
        setupFallenLeafAmountPickerView()
        setupFallenLeafAmountTextField()
        setupFlowerNameTextField()
        
        updateViewsWithSelectedFallenLeafAmountIndex()
    }
    
    // MARK: Push & Present Buttons
    private func setupPushPresentButtons()
    {
        buttons.forEach(setupButton)
    }
    
    private func setupButton(button: UIButton?)
    {
        button?.setBorder(cornerRadius: Constants.buttonCornerRadius,
                          color: button!.currentTitleColor,
                          width: Constants.buttonBorderWidth)
    }
    
    // MARK: Fallen Leaf Amount
    private func setupFallenLeafAmountPickerView()
    {
        fallenLeafAmountPickerView = UIPickerView()
        
        fallenLeafAmountPickerView.delegate = self
        fallenLeafAmountPickerView.dataSource = self
        
        fallenLeafAmountPickerView.showsSelectionIndicator = true
    }
    
    private func setupFallenLeafAmountTextField()
    {
        fallenLeafAmountTextField.setDoneToolbarAsInputAccessoryView()
        fallenLeafAmountTextField.inputView = fallenLeafAmountPickerView
        fallenLeafAmountTextField.tintColor = .clear
    }
    
    // MARK: Flower Name
    private func setupFlowerNameTextField()
    {
        flowerNameTextField.returnKeyType = .done
        flowerNameTextField.delegate = self
    }
    
    // MARK: Update
    private func updateViewsWithSelectedFallenLeafAmountIndex()
    {
        fallenLeafAmountPickerView.selectRow(selectedFallenLeafAmountIndex, inComponent: 0, animated: false)
        fallenLeafAmountTextField.text = LeafAmount.allCases[selectedFallenLeafAmountIndex].rawValue
    }
}

// MARK:- UIPickerViewDataSource
extension MainViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return LeafAmount.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return LeafAmount.allCases[row].rawValue
    }
}

// MARK:- UIPickerViewDelegate
extension MainViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // Update state
        selectedFallenLeafAmountIndex = row
        
        // Update UI
        fallenLeafAmountTextField.text = LeafAmount.allCases[row].rawValue
    }
}

// MARK:- UITextFieldDelegate
extension MainViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
}

// MARK:- Utils
private extension MainViewController
{
    var buttons: [UIButton?]
    {
        return [presentSpringButton, pushSpringButton, presentSummerButton, pushSummerButton, presentAutumnButton, pushAutumnButton, presentWinterButton, pushWinterButton]
    }
}
