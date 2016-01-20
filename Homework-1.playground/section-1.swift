// Homework 1
import Foundation

// The generateArray function randomly creates an array of Int optionals
//
// The following questions ask you to perform different calculations based
// on random arrays created by the function. Each time you run the playground
// you should get different results. You can force the playground to run again
// using the Editor --> Execute Playground menu item.  You don't need to be 
// familiar with the code inside this method.
func generateArray() -> [Int?] {
    let size = Int(arc4random() % 20)
    var array = [Int?]()
    var value: Int?
    
    for _ in 0...size {
        value = -10 + Int(arc4random() % 110)
        array.append(value >= 0 ? value : nil)
    }
    
    return array
}

// Question 1: Counting nils
//
// Write code that counts the number of nil values in array1
print("*************** Question 1 ***************")
let array1 = generateArray()

func countNils<T>(arr: [T?]) -> Int {
  return arr.filter{ $0 == nil }
            .reduce(0){ (total, _) in total + 1 }
}
let numNils = countNils(array1)
print("array1: \(array1)) \nHas \(numNils) nil values")


// Question 2: Mean
//
// Write code that calculates the mean value of the non nil elements in array1.
// You do not necessarily need to write functions. You can start your code
// directly under the declaration of array2
print("\n*************** Question 2 ***************")
let array2 = generateArray()

func getMeanVal(arr:[Int?]) -> Double {
  let cleaned = arr.filter{ $0 != nil }.map{ $0! }
  return Double(cleaned.reduce(0){ $0 + $1 }) / Double(cleaned.count)
}
let meanVal = getMeanVal(array2)
print("array2: \(array2) \nHas mean value \(meanVal)")


// Question 3: New Array
//
// Write code that creates a new array named nilFree that has the same elements
// as array3, except without the nil values. The elements in nilFree should be
// Ints, not Int optionals
print("\n*************** Question 3 ***************")
let array3 = generateArray()

func removeNils<T>(arr: [T?]) -> [T] {
  return arr.filter{ $0 != nil }.map { $0! }
}
let nilFree = removeNils(array3)
print("array3: \(array3) \nWithout nils is \(nilFree)")


// Question 4: Sort array
//
// Write code that will sort array4 using your own logic. You might want to
// review the logic for Selection Sort or even Bubble Sort. Find a sort
// algorithm that you like in a language that you are familiar with and then
// translate it to Swift. Resist the temptation to find a sort online that
// is already written in swift. Do not use Swift's sort method.
//
// Note that array4 is declared with var, so that it is a mutable array.
print("\n*************** Question 4 ***************")
var array4 = generateArray()

func myBubbleSort(arr: [Int?]) -> [Int?] {
  // translated from ruby...
  if arr.count <= 1 {
    return arr
  }
  var copy = arr
  var swapped = true
  while swapped {
    swapped = false
    let r = 0...copy.count-2
    for i in r {
      if copy[i] > copy[i+1] {
        swap(&copy[i], &copy[i+1])
        swapped = true
      }
    }
  }
  return copy
}
func bubbleSort(inout arr: [Int?]) {
  arr = myBubbleSort(arr)
}
print("UNSORTED     : \(array4))")
print("SWIFT SORT   : \(array4.sort { $0 < $1 })")
print("MY TEST SORT : \(myBubbleSort(array4))")
bubbleSort(&array4)
print("SORT IN PLACE: \(array4))")
