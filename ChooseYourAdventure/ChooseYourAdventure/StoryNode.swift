//
//  StoryNode.swift
//  ChooseYourAdventure
//
//  Created by m on 4/13/16.
//  Copyright © 2016 mr. All rights reserved.
//

import Foundation

struct StoryNode {
  var nodeId: String
  var title: String = ""
  var text: String = ""
  var question: String = ""
  var choices: [String : Int]
  
  init(id: String) {
    let filePath = NSBundle.mainBundle().pathForResource("StoryText", ofType: "json")!
    let data = NSData(contentsOfFile: filePath)!
    
    // The first step in processing the data is to serialize it into a JSON object. In swift, the return type of
    // this method is AnyObject?.  That is a wide open data type, it might be nil, or it might be anything else
    let options = NSJSONReadingOptions(rawValue: 0)
    let jsonObject = try! NSJSONSerialization.JSONObjectWithData(data, options: options)
    let dictionary =  jsonObject as! [String : AnyObject]
    
    if let node = dictionary[id] as? [String : AnyObject] {
      nodeId = id
      title = node["title"] as! String
      text = node["text"] as! String
      question = node["question"] as! String
      choices = node["choices"] as! [String : Int]
    }
    else {
      // exception?
      nodeId = "0"
      title = "Choice Missing"
      text = "Something Went Wrong."
      question = "A question here maybe?"
      choices = ["choice 1" : 0, "choice 2" : 1]
    }
    
  }
}
