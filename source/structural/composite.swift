/*:
🌿 Composite
-------------

The composite pattern is used to create hierarchical, recursive tree structures of related objects where any element of the structure may be accessed and utilised in a standard manner.

### Example
*/
protocol Developer {
  func writeCode()
}

protocol Team {
  var developers: [Developer] { set get }
  func addDeveloper(developer: Developer)
  func createProject()
}

struct SwiftDeveloper: Developer{
  func writeCode() {
    print("Swift Developer writes Swift code...")
  }
}

struct ObjCDeveloper: Developer{
  func writeCode() {
    print("ObjC Developer writes Objective-C code...")
  }
}

class BankTeam: Team {
  var developers = [Developer]()
  
  func addDeveloper(developer: Developer) {
    developers.append(developer)
  }
  
  func createProject() {
    for developer in developers {
      developer.writeCode()
    }
  }
}
/*:
### Usage:
*/
let team = BankTeam()
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: SwiftDeveloper())
team.createProject()
