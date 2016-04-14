//
//  CalculatorModel.swift
//  Calculator
//
//  Created by m on 4/14/16.
//  Copyright © 2016 mr. All rights reserved.
//

import Foundation

class CalculatorModel {
  
  var currentState: String = ""
  var arg1:Int?
  var operation:Operation?
  
  func processInput(s: String) -> String {
    if currentState == "" {
        currentState = s
    } else if let i:Int = Int(currentState) {
      if (i == 0) {
        currentState = s
      } else {
         currentState = "\(i)\(s)"
      }
    }
    return currentState
  }
  
  func clearState() -> String {
    currentState = "0"
    operation = nil
    return currentState
  }
  
  func addOperator(opp: String?) {
    arg1 = Int(currentState)
    currentState = ""
    if opp == "+" {
      operation = .addition
    } else if opp == "-" {
      operation = .subtraction
    }
    
  }
  
  func solve(secondArg: String) -> String {
    if (arg1 != nil), let arg2:Int = Int(secondArg) {
      if operation == .addition {
        currentState = "\(arg1! + arg2)"
      } else {
        currentState = "\(arg1! - arg2)"
      }
    }
    arg1 = nil
    operation = nil
    return currentState
  }
}