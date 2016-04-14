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
  var model = CalculatorModel()
  
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
    let s = "\(sender.tag)"
    displayField.text = model.processInput(s)
  }

  @IBAction func clearScreen(sender: AnyObject) {
    displayField.text = model.clearState()
  }
  
  @IBAction func addOperator(sender: AnyObject) {
    model.arg1 = Int(displayField.text!)
    displayField.text = ""
    model.addOperator(sender.currentTitle!)
    
  }
  
  @IBAction func solve(sender: AnyObject) {
    displayField.text = model.solve(displayField.text!)
  }
  
}