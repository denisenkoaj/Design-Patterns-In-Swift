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
🐉 State
---------

The state pattern is used to alter the behaviour of an object as its internal state changes.
The pattern allows the class for an object to apparently change at run-time.

### Example
*/
protocol Activity {
  func justDoIt()
}

struct Coding: Activity {
  func justDoIt() {
    print("Writing code...")
  }
}

struct Reading: Activity {
  func justDoIt() {
    print("Reading book...")
  }
}

struct Sleeping: Activity {
  func justDoIt() {
    print("Sleeping...")
  }
}

struct Training: Activity {
  func justDoIt() {
    print("Training...")
  }
}

struct Developer {
  var activity: Activity
  
  mutating func changeActivity() {
    if let _ = activity as? Sleeping {
      activity = Training()
    } else if let _ = activity as? Training {
      activity = Coding()
    } else if let _ = activity as? Coding {
      activity = Reading()
    } else if let _ = activity as? Reading {
      activity = Sleeping()
    }
  }
  
  func justDoIt() {
    activity.justDoIt()
  }
}
/*:
### Usage
*/
let activity = Sleeping()
var developer = Developer(activity: activity)
for i in 0..<10 {
  developer.justDoIt()
  developer.changeActivity()
}
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-State)
*/
