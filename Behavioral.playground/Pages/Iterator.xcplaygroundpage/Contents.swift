/*:
Behavioral
==========

>In software engineering, behavioral design patterns are design patterns that identify common communication patterns between objects and realize these patterns. By doing so, these patterns increase flexibility in carrying out this communication.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Behavioral_pattern)
*/
import Swift
import Foundation
/*:
🍫 Iterator
-----------

The iterator pattern is used to provide a standard interface for traversing a collection of items in an aggregate object without the need to understand its underlying structure.

### Example:
*/
protocol Iterator {
  func hasNext() -> Bool
  mutating func next() -> String
}

protocol Collection {
  func getIterator() -> Iterator
}

struct SwiftDeveloper: Collection {
  var name: String
  var skills: [String]
  
  private struct SkillIterator: Iterator {
    var index: Int
    var data: [String]
    func hasNext() -> Bool {
      return index < data.count
    }
    mutating func next() -> String {
      let result = data[index]
      index = index + 1
      return result
    }
  }
  
  func getIterator() -> Iterator {
    return SkillIterator(index: 0, data: skills)
  }
}
/*:
### Usage
*/
let skills = ["Swift", "ObjC", "Sketch", "PM"]
let swiftDeveloper = SwiftDeveloper(name: "Sergey Zapuhlyak", skills: skills)
var iterator = swiftDeveloper.getIterator()
print("Developer \(swiftDeveloper.name)")
print("Skills")
while iterator.hasNext() {
  print("\(iterator.next())")
}
