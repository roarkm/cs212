//
//  OrangeViewController.swift
//  Homework3
//
//  Created by Jason on 1/25/15.
//  Copyright (c) 2015 CCSF. All rights reserved.
//

import UIKit

class OrangeViewController : UIViewController {
  
  var appearanceCount: Int = 0
  
  override func viewWillAppear(animated: Bool) {
    print("\(NSStringFromClass(self.dynamicType)).\(__FUNCTION__)")
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(animated: Bool) {
    self.appearanceCount = self.appearanceCount + 1
    print("\(NSStringFromClass(self.dynamicType)) has appeared \(self.appearanceCount) times.")
    print("\(NSStringFromClass(self.dynamicType)).\(__FUNCTION__)")
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(animated: Bool) {
    print("\(NSStringFromClass(self.dynamicType)).\(__FUNCTION__)")
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(animated: Bool) {
    print("\(NSStringFromClass(self.dynamicType)).\(__FUNCTION__)")
    super.viewDidDisappear(animated)
  }
  
}
