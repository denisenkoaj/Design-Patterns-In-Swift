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
🏃 Visitor
----------

The visitor pattern is used to separate a relatively complex set of structured data classes from the functionality that may be performed upon the data that they hold.

### Example
*/
protocol Developer {
  func create(project: ProjectClass)
  func create(project: Database)
  func create(project: Test)
}

protocol ProjectElement {
  func beWritten(developer: Developer)
}

struct ProjectClass: ProjectElement {
  func beWritten(developer: Developer) {
    developer.create(project: self)
  }
}

struct Database: ProjectElement {
  func beWritten(developer: Developer) {
    developer.create(project: self)
  }
}

struct Test: ProjectElement {
  func beWritten(developer: Developer) {
    developer.create(project: self)
  }
}

struct Project: ProjectElement {
  var projectElements: [ProjectElement] = [ProjectClass(), Database(), Test()]
  
  func beWritten(developer: Developer) {
    for projectElement in projectElements {
      projectElement.beWritten(developer: developer)
    }
  }
}

struct JuniorDeveloper: Developer {
  func create(project: ProjectClass) {
    print("Writing poor class...")
  }
  
  func create(project: Database) {
    print("Drop database...")
  }
  
  func create(project: Test) {
    print("Creating not reliable test...")
  }
}

struct SeniorDeveloper: Developer {
  func create(project: ProjectClass) {
    print("Rewriting class after junior...")
  }
  
  func create(project: Database) {
    print("Fixing database...")
  }
  
  func create(project: Test) {
    print("Creating reliable test...")
  }
}
/*:
### Usage
*/
let project = Project()
let junior = JuniorDeveloper()
let senior = SeniorDeveloper()

print("Junior in Action")
project.beWritten(developer: junior)

print("")

print("Senior in Action")
project.beWritten(developer: senior)
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Visitor)
*/
