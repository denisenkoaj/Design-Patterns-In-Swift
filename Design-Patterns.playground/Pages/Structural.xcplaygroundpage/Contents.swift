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
🔌 Adapter
----------

The adapter pattern is used to provide a link between two otherwise incompatible types by wrapping the "adaptee" with a class that supports the interface required by the client.

### Example
*/
protocol Database {
  func insert()
  func update()
  func select()
  func remove()
}

class SwiftApp {
  func saveObject() {
    print("Saving Swift Object...")
  }
  
  func updateObject() {
    print("Updating Swift Object...")
  }
  
  func loadObject() {
    print("Loading Swift Object...")
  }
  
  func deleteObject() {
    print("Deleting Swift Object...")
  }
}

class AdapterSwiftAppToDatabase: SwiftApp, Database {
  func insert() {
    saveObject()
  }
  
  func update() {
    updateObject()
  }
  
  func select() {
    loadObject()
  }
  
  func remove() {
    deleteObject()
  }
}

struct DatabaseManager {
  var database: Database
  func run() {
    database.insert()
    database.update()
    database.select()
    database.remove()
  }
}
/*:
### Usage
*/
let databaseManager = DatabaseManager(database: AdapterSwiftAppToDatabase())
databaseManager.run()
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Adapter)
*/
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
/*:
🎁 Façade
---------

The facade pattern is used to define a simplified interface to a more complex subsystem.

### Example
*/
class Job {
  func doJob() {
    print("Job is progress...")
  }
}

class BugTracker {
  var isActiveSprint = false
  
  func startSprint() {
    print("Sprint is active")
    isActiveSprint = true
  }
  
  func stopSprint() {
    print("Sprint is not active")
    isActiveSprint = false
  }
}

class Developer {
  func doJobBeforeDeadline(bugTracker: BugTracker) {
    if bugTracker.isActiveSprint {
      print("Developer is solving problems...")
    } else {
      print("Developer is reading the news...")
    }
  }
}

class Workflow {
  let developer = Developer()
  let job = Job()
  let bugTracker = BugTracker()
  func solveProblems() {
    job.doJob()
    bugTracker.startSprint()
    developer.doJobBeforeDeadline(bugTracker: bugTracker)
  }
}
/*:
### Usage
*/
let workflow = Workflow()
workflow.solveProblems()
/*:
## 🍃 Flyweight
The flyweight pattern is used to minimize memory usage or computational expenses by sharing as much as possible with other similar objects.
### Example
*/
protocol Developer {
  func writeCode()
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

enum Languages: String {
  case Swift
  case ObjC
  
  var description: String {
    return self.rawValue
  }
}

struct DeveloperFactory {
  private var developers = [String: Developer]()
  
  mutating func developer(by language: Languages) -> Developer {
    if let value = developers[language.description] {
      return value
    } else {
      var value: Developer? = nil
      print("Hiring \(language.description) developer ")
      switch language {
      case .Swift:
        value = SwiftDeveloper()
      case .ObjC:
        value = ObjCDeveloper()
      }
      developers[language.description] = value
      return value!
    }
  }
}
/*:
### Usage
*/
var developerFactory = DeveloperFactory()
var developers = [Developer]()
developers.append(developerFactory.developer(by: .Swift))
developers.append(developerFactory.developer(by: .Swift))
developers.append(developerFactory.developer(by: .Swift))
developers.append(developerFactory.developer(by: .ObjC))
developers.append(developerFactory.developer(by: .ObjC))
developers.append(developerFactory.developer(by: .ObjC))
for developer in developers {
  developer.writeCode()
}
/*:
☔ Proxy
------------------

The proxy pattern is used to provide a surrogate or placeholder object, which references an underlying object. 

### Example
*/
protocol Project {
  func run()
}

struct RealProject: Project {
  var url: String
  
  func load() {
    print("Loading project from url \(url) ...")
  }
  
  init(url: String) {
    self.url = url
    load()
  }
  
  func run() {
    print("Running project \(url) ...")
  }
}

class ProxyProject: Project {
  var url: String
  var realProject: RealProject?
  
  func run() {
    if realProject == nil {
      realProject = RealProject(url: url)
    }
    realProject!.run()
  }
  
  init(url: String) {
    self.url = url
  }
}
/*:
### Usage
*/
var project = ProxyProject(url: "https://github.com/zsergey/realProject")
project.run()
