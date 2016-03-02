//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by m on 2/29/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var rpsGame:RPSGame?
  @IBOutlet weak var rockButton: UIButton!
  @IBOutlet weak var paperButton: UIButton!
  @IBOutlet weak var scissorButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rpsGame = RPSGame()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func play(sender: UIButton) {
    if sender == rockButton {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let evalPlayVC = storyboard.instantiateViewControllerWithIdentifier("evalPlay") as! EvalPlayViewController
      rpsGame!.userMove = .Rock
      evalPlayVC.rpsGame = rpsGame
      self.presentViewController(evalPlayVC, animated: true, completion: { });
    } else if sender == paperButton {
      self.performSegueWithIdentifier("showEvalPlay", sender: sender)
    }
  }

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if let sender = sender as? UIButton {
      if sender == scissorButton {
        rpsGame!.userMove = .Scissors
      } else if sender == paperButton{
        rpsGame!.userMove = .Paper
      }
    }
    let evPlayVC = segue.destinationViewController as! EvalPlayViewController
    evPlayVC.rpsGame = rpsGame
  }
  
}

