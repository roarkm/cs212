//
//  ViewController.swift
//  ChooseYourAdventure
//
//  Created by m on 4/12/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class ViewController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func startOver() {
    // load root story node...
    self.popToRootViewControllerAnimated(true)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func loadVCforStoryNode(nodeId: String) {
    let vc = StoryNodeViewController()
    vc.nodeId = nodeId
    self.pushViewController(vc, animated: true)
  }


}

