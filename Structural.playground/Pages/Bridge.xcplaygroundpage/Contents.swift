/*:
Structural
==========

>In software engineering, structural design patterns are design patterns that ease the design by identifying a simple way to realize relationships between entities.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Structural_pattern)
*/
import Swift
import Foundation
/*:
🌉 Bridge
----------

The bridge pattern is used to separate the abstract elements of a class from the implementation details, providing the means to replace the implementation details without modifying the abstraction.

### Example
*/
protocol Developer {
  func writeCode()
}

protocol Program {
  var developer: Developer { get set }
  func develop()
}

struct SwiftDeveloper: Developer {
  func writeCode() {
    print("Swift Developer writes Swift code...")
  }
}

struct ObjCDeveloper: Developer {
  func writeCode() {
    print("ObjC Developer writes Objective-C code...")
  }
}

struct BankSystem: Program {
  var developer: Developer
  
  func develop() {
    print("Bank System development in progress...")
    developer.writeCode()
  }
}

struct StockExchange: Program {
  var developer: Developer
  
  func develop() {
    print("Stock Exchange development in progress...")
    developer.writeCode()
  }
}
/*:
### Usage
*/
let programs: [Program] = [BankSystem(developer: ObjCDeveloper()),
                           StockExchange(developer: SwiftDeveloper())]
for program in programs {
  program.develop()
}
