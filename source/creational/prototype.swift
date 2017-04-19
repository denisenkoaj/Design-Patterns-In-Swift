/*:
🃏 Prototype
------------

The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone. 
This practise is particularly useful when the construction of a new object is inefficient.

### Example
*/
protocol Copyable {
  func copy() -> Any
}

struct Project: Copyable {
  var id: Int
  var name: String
  var source: String
  
  func copy() -> Any {
    let object = Project(id: id, name: name, source: source)
    return object
  }
}

struct ProjectFactory {
  var project: Project
  func cloneProject() -> Project {
    return project.copy() as! Project
  }
}
/*:
### Usage
*/
let master = Project(id: 1, name: "Playground.swift", source: "let sourceCode = SourceCode()")
let factory = ProjectFactory(project: master)
let masterClone = factory.cloneProject()
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Prototype)
*/
