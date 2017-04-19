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
🌰 Abstract Factory
-------------------

The abstract factory pattern is used to provide a client with a set of related or dependant objects. 
The "family" of objects created by the factory are determined at run-time.

### Example
*/
protocol Developer {
  func writeCode()
}

protocol Tester {
  func testCode()
}

protocol ProjectManager {
  func manageProject()
}

protocol ProjectTeamFactory {
  var developer: Developer { get }
  var tester:  Tester { get }
  var projectManager: ProjectManager { get }
}

// Team of Bank.
struct SwiftDeveloper: Developer {
  func writeCode() {
    print("Swift developer writes Swift code...")
  }
}

struct QATester: Tester {
  func testCode() {
    print("QA tester tests banking code...")
  }
}

struct BankingPM: ProjectManager {
  func manageProject() {
    print("BankingPM manages banking project...")
  }
}

struct BankingTeamFactory: ProjectTeamFactory {
  var developer: Developer {
    return SwiftDeveloper()
  }
  var tester: Tester {
    return QATester()
  }
  var projectManager: ProjectManager {
    return BankingPM()
  }
}

// Team of Website.
struct PhpDeveloper: Developer {
  func writeCode() {
    print("Php developer writes php code...")
  }
}

struct ManualTester: Tester {
  func testCode() {
    print("Manual tester tests Website...")
  }
}

struct WebsitePM: ProjectManager {
  func manageProject() {
    print("WebsitePM manages Website project...")
  }
}

struct WebsiteTeamFactory: ProjectTeamFactory {
  var developer: Developer {
    return PhpDeveloper()
  }
  var tester: Tester {
    return ManualTester()
  }
  var projectManager: ProjectManager {
    return WebsitePM()
  }
}

// Projects.
enum Projects {
  case bankBusinessOnline
  case auctionSite
  
  var name: String {
    switch self {
    case .bankBusinessOnline:
      return "Bank business online"
    case .auctionSite:
      return "Auction site"
    }
  }
  
  var factory: ProjectTeamFactory {
    switch self {
    case .bankBusinessOnline:
      return BankingTeamFactory()
    case .auctionSite:
      return WebsiteTeamFactory()
    }
  }
  
  func createProject() {
    print("Создание проекта \(name)")
    let projectFactory = factory
    projectFactory.developer.writeCode()
    projectFactory.tester.testCode()
    projectFactory.projectManager.manageProject()
  }
}
/*:
### Usage
*/
Projects.bankBusinessOnline.createProject()
Projects.auctionSite.createProject()
/*:
👷 Builder
----------

The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. 
An external class controls the construction algorithm.

### Example
*/
enum Cms {
  case wordpress
  case alifresco
}

struct Website {
  var name: String?
  var cms: Cms?
  var price: Int?
  
  func printWebsite(){
    guard let name = name, let cms = cms, let price = price else {
      return
    }
    print("Name \(name), cms \(cms), price \(price)")
  }
}

protocol WebsiteBuilder {
  var website: Website? { set get }
  func createWebsite()
  func buildName()
  func buildCms()
  func buildPrice()
}

class VisitCardWebsiteBuilder: WebsiteBuilder {
  internal var website: Website?
  
  internal func createWebsite() {
    self.website = Website()
  }
  
  internal func buildName() {
    self.website?.name = "Visit Card"
  }
  
  internal func buildCms() {
    self.website?.cms = .wordpress
  }
  
  internal func buildPrice() {
    self.website?.price = 500
  }
}

class EnterpriseWebsiteBuilder: WebsiteBuilder {
  internal var website: Website?
  
  internal func createWebsite() {
    self.website = Website()
  }
  
  internal func buildName() {
    self.website?.name = "Enterprise website"
  }
  
  internal func buildCms() {
    self.website?.cms = .alifresco
  }
  
  internal func buildPrice() {
    self.website?.price = 10000
  }
}

struct Director {
  var builder: WebsiteBuilder
  
  func buildWebsite() -> Website {
    builder.createWebsite()
    builder.buildName()
    builder.buildCms()
    builder.buildPrice()
    return builder.website!
  }
}
/*:
### Usage
*/
let director = Director(builder: EnterpriseWebsiteBuilder())
let website = director.buildWebsite()
website.printWebsite()
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Builder)
*/
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
/*:
💍 Singleton
------------

The singleton pattern ensures that only one object of a particular class is ever created.
All further references to objects of the singleton class refer to the same underlying instance.
There are very few applications, do not overuse this pattern!

### Example:
*/
struct Game {
  static let sharedGame = Game()
  
  private init() {
    
  }
}
/*:
### Usage:
*/
let game = Game.sharedGame
