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
