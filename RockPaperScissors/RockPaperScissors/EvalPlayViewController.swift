//
//  EvalPlayViewController.swift
//  RockPaperScissors
//
//  Created by m on 2/29/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class EvalPlayViewController: UIViewController {

  var rpsGame:RPSGame?
  @IBOutlet weak var displayLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rpsGame?.playComputerMove()
    displayLabel.text = rpsGame!.outcomeDescription()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }

}
