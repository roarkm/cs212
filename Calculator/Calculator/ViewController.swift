//
//  ViewController.swift
//  Calculator
//
//  Created by m on 2/25/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

enum Operation {
  case addition
  case subtraction
}

class ViewController: UIViewController {
  var arg1:Int?
  var operation:Operation?
  
  @IBOutlet weak var displayField: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func numberPressed(sender: AnyObject) {
    if displayField.text == nil || displayField.text == "" {
        displayField.text = "\(sender.tag!)"
    } else if let i:Int = Int(displayField.text!) {
      if (i == 0) {
        displayField.text = "\(sender.tag!)"
      } else {
        displayField.text = "\(i)\(sender.tag!)"
      }
    }
  }

  @IBAction func clearScreen(sender: AnyObject) {
    displayField.text = "0"
    operation = nil
  }
  
  @IBAction func addOperator(sender: AnyObject) {
    arg1 = Int(displayField.text!)
    displayField.text = ""
    if sender.currentTitle == "+" {
      operation = .addition
    } else if sender.currentTitle == "-" {
      operation = .subtraction
    }
    
  }
  
  @IBAction func solve(sender: AnyObject) {
    if (arg1 != nil), let arg2:Int = Int(displayField.text!) {
      if operation == .addition {
        displayField.text = "\(arg1! + arg2)"
      } else {
        displayField.text = "\(arg1! - arg2)"
      }
    }
    arg1 = nil
    operation = nil
  }
  
}