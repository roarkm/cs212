//
//  ViewController.swift
//  ThreeTextFields
//
//  Created by m on 2/29/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var uiSwitch: UISwitch!
  @IBOutlet weak var textOne: UITextField!
  @IBOutlet weak var textTwo: UITextField!
  @IBOutlet weak var textThree: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    textTwo.keyboardType = .NumberPad
  }

 override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func flipSwitch(sender: AnyObject) {
    if !uiSwitch.on {
      textThree.resignFirstResponder()
      textThree.backgroundColor = UIColor.redColor()
    } else {
      textThree.backgroundColor = UIColor.whiteColor()
      textThree.becomeFirstResponder()
    }
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    return (textField == textThree) ? (uiSwitch.on) : true
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    if textField == textOne {
      if textField.text?.characters.count >= 5 {
        return false
      }
    }
    else if textField == textTwo {
      var txtNumStr:String = String(textField.text!.characters.dropFirst()) // remove the $
      txtNumStr = txtNumStr.stringByReplacingOccurrencesOfString(",", withString: "") // remove commas
      
      if !string.isEmpty {
        // adding a digit
        let new:Double = Double(string)! * 0.01
        let old:Double = Double(txtNumStr)! * 10
        textField.text = self.convertNumberToDollarString(old + new)
        return false
        
      } else {
        // delete key pressed
        // remove last digit and divide by 10
        let old:Double = Double(String(txtNumStr.characters.dropLast()))! * 0.1
        textField.text = self.convertNumberToDollarString(old)
        return false
      }
    }
    return true // is textThree (no restrictions)
  }
  
  func convertNumberToDollarString(num:Double) -> String {
    let formatter:NSNumberFormatter = NSNumberFormatter()
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.minimumIntegerDigits  = 1
    formatter.alwaysShowsDecimalSeparator = true
    formatter.numberStyle = .CurrencyStyle
    
    return formatter.stringFromNumber(num)!
  }
  
}