//
//  StoryManager.swift
//  ChooseYourAdventure
//
//  Created by m on 4/13/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

struct StoryNode {
  var nodeId: Int
  var storyText: String? = ""
  var choices: [[String : Int]]
  
  init(id: Int) {
    // load id from json file
    nodeId = id
    storyText = ""
    choices = [[String:Int]]()
  }
}

struct StoryManager {
  
  func loadRootStoryNode() {
    
  }
  
  func loadStoryNode(node: String) {
    
  }

}
