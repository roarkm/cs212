//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by m on 4/14/16.
//  Copyright © 2016 mr. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {

  var matches: [RPSGame] = [RPSGame]()
  
  @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
      super.viewDidLoad()
      print(matches)
      // Do any additional setup after loading the view.
      tableView.registerNib(UINib(nibName: "HistoryCellPrototype", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    cell.textLabel!.text = appDelegate.matches[indexPath.row].outcomeDescription()
    
    return cell
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    return appDelegate.matches.count
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
