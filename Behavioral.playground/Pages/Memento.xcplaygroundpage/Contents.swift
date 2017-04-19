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
💾 Memento
----------

The memento pattern is used to capture the current state of an object and store it in such a manner that it can be restored at a later time without breaking the rules of encapsulation.

### Example
*/
struct Project {
  var version: String
  var code: String
  
  func save() -> Save {
    return Save(version: version, code: code)
  }
  
  mutating func load(save: Save) {
    version = save.version
    code = save.code
  }
  
  func description() -> String {
    return "Project version = \(version): \n'\(code)'\n"
  }
}

struct Save {
  var version: String
  var code: String
}

struct GithubRepo {
  var save: Save
}
/*:
 ### Usage
*/
print("Creating new project. Version 1.0")
var project = Project(version: "1.0", code: "let index = 0")
print(project.description())

print("Saving current version to github")
let github = GithubRepo(save: project.save())

print("Updating project to Version 1.1")
print("Writing poor code...")
print("Set version 1.1")
project.version = "1.1"
project.code = "let index = 0\nindex = 5"
print(project.description())

print("Something went wrong")
print("Rolling back to Version 1.0")

project.load(save: github.save)
print("Project after rollback")
print(project.description())
