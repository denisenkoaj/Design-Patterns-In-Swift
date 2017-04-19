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
🍧 Decorator
------------

The decorator pattern is used to extend or alter the functionality of objects at run- time by wrapping them in an object of a decorator class. 
This provides a flexible alternative to using inheritance to modify behaviour.

### Example
*/
protocol Developer {
  func makeJob() -> String
}

struct SwiftDeveloper: Developer {
  func makeJob() -> String {
    return "Write Swift code"
  }
}

class DeveloperDecorator: Developer {
  var developer: Developer
  func makeJob() -> String {
    return developer.makeJob()
  }
  init(developer: Developer) {
    self.developer = developer
  }
}

class SeniorSwiftDeveloper: DeveloperDecorator {
  let codeReview = "Make code review"
  override func makeJob() -> String {
    return super.makeJob() + " & " + codeReview
  }
}

class SwiftTeamLead: DeveloperDecorator {
  let sendWeekReport = "Send week report"
  override func makeJob() -> String {
    return super.makeJob() + " & " + sendWeekReport
  }
}
/*:
### Usage:
*/
let developer = SwiftTeamLead(developer: SeniorSwiftDeveloper(developer: SwiftDeveloper()))
print(developer.makeJob())
