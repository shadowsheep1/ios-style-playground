//
//  ViewController.swift
//  Style Playground
//
//  Created by shadowsheep on 29/04/2020.
//  Copyright © 2020 shadowsheep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    
    let accessory: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .lightGray
        accessoryView.alpha = 0.6
        return accessoryView
    }()
    
    let doneButton: UIButton = {
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(StyleManager.colorBlue(theme: StyleManager.getTheme()), for: .normal)
        doneButton.addTarget(self, action:#selector(doneButtonTapped), for: .touchUpInside)
        doneButton.showsTouchWhenHighlighted = true
        return doneButton
    }()
    
    func addAccessory() {
        accessory.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        accessory.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        accessory.addSubview(doneButton)
        
        self.myTextField.inputAccessoryView = accessory
        
        NSLayoutConstraint.activate([
            doneButton.trailingAnchor.constraint(equalTo:accessory.trailingAnchor, constant: -20),
            doneButton.centerYAnchor.constraint(equalTo:accessory.centerYAnchor),
        ])
    }
    
    @objc func doneButtonTapped() {
        self.myTextField.resignFirstResponder()
    }
    
    @IBAction func toolbarDoneClick(_ sender: Any) {
        self.myTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.addAccessory()
    }
    
    @IBAction func toggleTheme(_ sender: Any) {
        if StyleManager.getTheme() == StyleManager.themeDefault {
            StyleManager.setTheme(theme: StyleManager.themeVariant1, viewController: self)
        } else {
            StyleManager.setTheme(theme: StyleManager.themeDefault, viewController: self)
        }
    }
    
}

