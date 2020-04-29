//
//  ViewController.swift
//  Style Playground
//
//  Created by shadowsheep on 29/04/2020.
//  Copyright © 2020 shadowsheep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var keyboardToolbar: UIToolbar!
    @IBOutlet weak var myTextField: UITextField!
    
    @IBAction func toolbarDoneClick(_ sender: Any) {
        self.myTextField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.myTextField.inputAccessoryView = self.keyboardToolbar
    }


}

