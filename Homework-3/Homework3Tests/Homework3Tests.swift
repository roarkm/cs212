//
//  Homework3Tests.swift
//  Homework3Tests
//
//  Created by Jason on 1/25/15.
//  Copyright (c) 2015 CCSF. All rights reserved.
//

import UIKit
import XCTest
@testable import Homework3

class Homework3Tests: XCTestCase {
  
  var orangeVC: OrangeViewController?
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.orangeVC = OrangeViewController()
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testAppearanceCount() {
    // This is an example of a functional test case.
    self.orangeVC?.viewDidAppear(false)
    self.orangeVC?.viewDidAppear(false)
    self.orangeVC?.viewDidAppear(false)
    XCTAssert(self.orangeVC?.appearanceCount == 3, "Appearnce count should match appearances")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock() {
        // Put the code you want to measure the time of here.
    }
  }
    
}
