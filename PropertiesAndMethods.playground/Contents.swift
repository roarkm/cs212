//: Playground - noun: a place where people can play

import UIKit

struct Circle {
  init() {
    radius = 0
  }
  init(_ r: Double) {
    radius = r
  }
  
  var radius:Double {
    didSet(oldValue) {
      if radius < 0 {
        radius = 0
      }
    }
  }
  
  var circumfirence:Double {
    get {
      return 2 * M_PI * radius
    }
  }
  
  var area:Double {
    get {
      return M_PI * pow(radius, 2.0)
    }
  }
}

let c = Circle()
c.radius
let b = Circle(4.0)
b.radius
var d = Circle()
d.radius = -1
d.radius

class CircleCollection {
  init() {
    circles = [Circle]()
  }
  
  var circles: [Circle]
  
  func removeCirclesWithRadiusLargerThan(min:Double, butSmallerThan:Double) {
    circles = circles.filter{ !( $0.radius > min && $0.radius < butSmallerThan) }
  }
  
  var count:Int {
    get {
      return circles.count
    }
  }
}

let collection = CircleCollection()
for i in 1...77 {
  collection.circles.append(Circle(Double(i)))
}
collection.removeCirclesWithRadiusLargerThan(3.0, butSmallerThan:5.0)
//for c in collection.circles {
//  print("\(c.radius)")
//}


class ToDoItem {
  
  init(task t:String, priority p:Int, dueDate dd:NSDate?) {
    task = t
    priority = p
    dueDate = dd
  }
  init() {
    task = ""
    priority = 0
  }
  
  var task:String
  var dueDate:NSDate?
  var priority:Int {
    didSet(oldValue) {
      if priority < 0 {
        priority = 0
      } else if priority > 10 {
        priority = 10
      }
    }
  }
  func fullDescription() -> String {
    var ddString = ""
    if let dueDate = dueDate {
      ddString = "\nDue Date: \(dueDate)"
    }
    return "Task: \"\(task)\"\nPriority: \"\(priority)\"" + ddString
  }
}

class AnnotatedToDoItem : ToDoItem {
  var note:String?
  init(task t:String, priority p:Int, dueDate dd:NSDate?, note n:String?) {
    note = n
    super.init(task: t, priority: p, dueDate: dd)
  }
  override func fullDescription() -> String {
    var noteStr = ""
    if let note = note {
      noteStr = "\nNote: \(note)"
    }
    return super.fullDescription() + noteStr
  }
}

var td = AnnotatedToDoItem(task: "do stuff", priority: 1, dueDate: nil, note: "do it good")
td.dueDate = NSDate()
print("\(td.fullDescription())")
