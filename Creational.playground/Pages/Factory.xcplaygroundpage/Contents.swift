/*:
Creational
==========

> In software engineering, creational design patterns are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. The basic form of object creation could result in design problems or added complexity to the design. Creational design patterns solve this problem by somehow controlling this object creation.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Creational_pattern)
*/
import Swift
import Foundation
/*:
🏭 Factory Method
-----------------

The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.

### Example
*/
protocol Developer {
  func writeCode()
}

struct ObjCDeveloper: Developer {
  func writeCode() {
    print("ObjC developer writes Objective C code...")
  }
}

struct SwiftDeveloper: Developer {
  func writeCode() {
    print("Swift developer writes Swift code...")
  }
}

protocol DeveloperFactory {
  func newDeveloper() -> Developer
}

struct ObjCDeveloperFactory: DeveloperFactory {
  func newDeveloper() -> Developer {
    return ObjCDeveloper()
  }
}

struct SwiftDeveloperFactory: DeveloperFactory {
  func newDeveloper() -> Developer {
    return SwiftDeveloper()
  }
}

enum Languages {
  case objC
  case swift
  
  var factory: DeveloperFactory {
    switch self {
    case .objC:
      return ObjCDeveloperFactory()
    case .swift:
      return SwiftDeveloperFactory()
    }
  }
}
/*:
### Usage
*/
let developer = Languages.swift.factory.newDeveloper()
developer.writeCode()
