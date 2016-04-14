//
//  StoryNodeViewController.swift
//  ChooseYourAdventure
//
//  Created by m on 4/13/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class StoryNodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var storyTextView: UITextView!
  @IBOutlet weak var storyQuestionView: UITextView!
  @IBOutlet weak var answersTableView: UITableView!
  
  var nodeId: String = ""
  var node: StoryNode?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start Over", style: UIBarButtonItemStyle.Done, target: self.navigationController, action: "startOver")
    loadNewNode(nodeId)
    answersTableView.registerNib(UINib(nibName: "AnswerCellPrototype", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Cell")
  }
  
  func loadNewNode(id: String) {
    node = StoryNode(id: id)
    titleLabel.text = node!.title
    storyTextView.text = node!.text
    storyQuestionView.text = node!.question
    
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table View
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return node!.choices.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
    cell.textLabel!.text = Array(node!.choices.keys)[indexPath.row]
//    cell.tag = node!.choices[Array(node!.choices.keys)[indexPath.row]]!
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print(node!.choices[Array(node!.choices.keys)[indexPath.row]]!)
    if let navVC = self.navigationController as? ViewController {
      navVC.loadVCforStoryNode(String(node!.choices[Array(node!.choices.keys)[indexPath.row]]!))
    }
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
