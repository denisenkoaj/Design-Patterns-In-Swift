
Design Patterns implemented in Swift 3.1
========================================
A short cheat-sheet with Xcode 8.3.2 Playground ([Design-Patterns.zip](https://raw.githubusercontent.com/zsergey/Design-Patterns-In-Swift/master/Design-Patterns.zip)).

👷 Project maintained by: [@zsergey](http://twitter.com/zsergey) (Sergey Zapuhlyak)

🚀 How to generate README, Playground and zip from source: [GENERATE.md](https://github.com/zsergey/Design-Patterns-In-Swift/blob/master/GENERATE.md)

## Table of Contents

* [Behavioral](#behavioral)
* [Creational](#creational)
* [Structural](#structural)


```swift

```

🐝 Chain Of Responsibility
--------------------------

The chain of responsibility pattern is used to process varied requests, each of which may be dealt with by a different handler.

### Example:

```swift

protocol Notifier {
  var priority: Int { set get }
  var nextNotifier: Notifier? { set get }
  func write(_ message: String)
}

extension Notifier {
  func notifyManager(message: String, level: Int) {
    if level >= priority {
      write(message)
    }
    if let nextNotifie = self.nextNotifier {
      nextNotifie.notifyManager(message: message, level: level)
    }
  }
}

enum Priority {
  case routine
  case important
  case asSoonAsPossible
}

struct SimpleReportNotifier: Notifier {
  internal var nextNotifier: Notifier?
  internal var priority: Int
  
  func write(_ message: String) {
    print("Notifying using simple report: \(message)")
  }
}

struct EmailNotifier: Notifier {
  internal var nextNotifier: Notifier?
  internal var priority: Int
  
  func write(_ message: String) {
    print("Sending email: \(message)")
  }
}

struct SMSNotifier: Notifier {
  internal var nextNotifier: Notifier?
  internal var priority: Int
  
  func write(_ message: String) {
    print("Sending sms to manager: \(message)")
  }
}
```

### Usage

```swift

let smsNotifier = SMSNotifier(nextNotifier: nil, priority: Priority.asSoonAsPossible.hashValue)
let emailNotifier = EmailNotifier(nextNotifier: smsNotifier, priority: Priority.important.hashValue)
let reportNotifier = SimpleReportNotifier(nextNotifier: emailNotifier, priority: Priority.routine.hashValue)

reportNotifier.notifyManager(message: "Everything is OK", level: Priority.routine.hashValue)
reportNotifier.notifyManager(message: "Something went wrong", level: Priority.important.hashValue)
reportNotifier.notifyManager(message: "Houston, we've had a problem here!", level: Priority.asSoonAsPossible.hashValue)
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Chain-Of-Responsibility)

```swift

```

👫 Command
----------

The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object. The command may then be executed immediately or held for later use.

### Example:

```swift

struct Database {
  func insert() {
    print("Inserting record...")
  }
  
  func update() {
    print("Updating record...")
  }
  
  func select() {
    print("Reading record...")
  }
  
  func delete() {
    print("Deleting record...")
  }
}

protocol Command {
  var database: Database { set get }
  func execute()
}

struct InsertCommand: Command {
  internal var database: Database
  
  func execute() {
    database.insert()
  }
}

struct UpdateCommand: Command {
  internal var database: Database
  
  func execute() {
    database.update()
  }
}

struct SelectCommand: Command {
  internal var database: Database
  
  func execute() {
    database.select()
  }
}

struct DeleteCommand: Command {
  internal var database: Database
  
  func execute() {
    database.delete()
  }
}

struct Developer {
  var insert, update, select, delete: Command
  
  func insertRecord() {
    insert.execute()
  }
  
  func updateRecord() {
    update.execute()
  }
  
  func selectRecord() {
    select.execute()
  }
  
  func deleteRecord() {
    delete.execute()
  }
}
```

### Usage:

```swift

let database = Database()
let insertCommand = InsertCommand(database: database)
let updateCommand = UpdateCommand(database: database)
let selectCommand = SelectCommand(database: database)
let deleteCommand = DeleteCommand(database: database)

let developer = Developer(insert: insertCommand, update: updateCommand, select: selectCommand, delete: deleteCommand)
developer.insertRecord()
developer.updateRecord()
developer.selectRecord()
developer.deleteRecord()
```

🎶 Interpreter
--------------

The interpreter pattern is used to evaluate sentences in a language.

### Example

```swift

protocol Expression {
  func interpret(_ context: String) -> Bool
}

struct AndExpression: Expression {
  var expression1: Expression
  var expression2: Expression
  
  func interpret(_ context: String) -> Bool {
    return expression1.interpret(context) && expression2.interpret(context)
  }
}

struct OrExpression: Expression {
  var expression1: Expression
  var expression2: Expression
  
  func interpret(_ context: String) -> Bool {
    return expression1.interpret(context) || expression2.interpret(context)
  }
}

struct TerminalExpression: Expression {
  var data: String
  
  func interpret(_ context: String) -> Bool {
    return context.contains(data)
  }
}
```

### Usage

```swift

struct Interpreter {
  static func getAppleExpression() -> Expression {
    let swift = TerminalExpression(data: "Swift")
    let objC = TerminalExpression(data: "Objective-C")
    return OrExpression(expression1: objC, expression2: swift)
  }
  
  static func getJavaEEExpression() -> Expression {
    let java = TerminalExpression(data: "Java")
    let spring = TerminalExpression(data: "Spring")
    return AndExpression(expression1: java, expression2: spring)
  }
}

let appleExpression = Interpreter.getAppleExpression()
let javaExpression = Interpreter.getJavaEEExpression()
print("Is Developer an Apple Developer \(appleExpression.interpret("Swift"))")
print("Does developer knows Java EE \(javaExpression.interpret("Java Spring"))")
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Interpreter)

```swift

```

🍫 Iterator
-----------

The iterator pattern is used to provide a standard interface for traversing a collection of items in an aggregate object without the need to understand its underlying structure.

### Example:

```swift

protocol Iterator {
  func hasNext() -> Bool
  mutating func next() -> String
}

protocol Collection {
  func getIterator() -> Iterator
}

struct SwiftDeveloper: Collection {
  var name: String
  var skills: [String]
  
  private struct SkillIterator: Iterator {
    var index: Int
    var data: [String]
    func hasNext() -> Bool {
      return index < data.count
    }
    mutating func next() -> String {
      let result = data[index]
      index = index + 1
      return result
    }
  }
  
  func getIterator() -> Iterator {
    return SkillIterator(index: 0, data: skills)
  }
}
```

### Usage

```swift

let skills = ["Swift", "ObjC", "Sketch", "PM"]
let swiftDeveloper = SwiftDeveloper(name: "Sergey Zapuhlyak", skills: skills)
var iterator = swiftDeveloper.getIterator()
print("Developer \(swiftDeveloper.name)")
print("Skills")
while iterator.hasNext() {
  print("\(iterator.next())")
}
```

💐 Mediator
-----------

The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.

### Example

```swift

protocol Chat {
  func sendMessage(_ message: String, from user: User)
}

protocol User {
  var ID: Int { set get }
  var name: String { set get }
  var chat: Chat { set get }
  func sendMessage(_ message: String)
  func getMessage(_ message: String)
}

struct Admin: User {
  internal var ID: Int
  internal var name: String
  internal var chat: Chat
  
  func sendMessage(_ message: String) {
    chat.sendMessage(message, from: self)
  }
  
  func getMessage(_ message: String) {
    print("\(name) received message: \(message)")
  }
}

struct Client: User {
  internal var ID: Int
  internal var name: String
  internal var chat: Chat
  
  func sendMessage(_ message: String) {
    chat.sendMessage(message, from: self)
  }
  
  func getMessage(_ message: String) {
    print("\(name) received message: \(message)")
  }
}

class Telegram: Chat {
  var admin: Admin?
  var clients: [Client]?
  
  func addClient(client: Client) {
    if clients == nil {
      clients = [Client]()
    }
    clients?.append(client)
  }
  
  func sendMessage(_ message: String, from user: User) {
    if let clients = clients {
      for client in clients {
        if client.ID != user.ID {
          client.getMessage(message)
        }
      }
    }
    
    admin?.getMessage(message)
  }
}
```

### Usage

```swift

var telegram = Telegram()
let admin = Admin(ID: 1, name: "Pavel Durov", chat: telegram)
let zsergey = Client(ID: 2, name: "Sergey Zapuhlyak", chat: telegram)
let azimin = Client(ID: 3, name: "Alex Zimin", chat: telegram)
telegram.admin = admin
telegram.addClient(client: zsergey)
telegram.addClient(client: azimin)

zsergey.sendMessage("Hello, I am Sergey Zapuhlyak")
admin.sendMessage("I am Administrator!")
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Mediator)

```swift

```

💾 Memento
----------

The memento pattern is used to capture the current state of an object and store it in such a manner that it can be restored at a later time without breaking the rules of encapsulation.

### Example

```swift

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
```

 ### Usage

```swift

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
```

👓 Observer
-----------

The observer pattern is used to allow an object to publish changes to its state.
Other objects subscribe to be immediately notified of any changes.

### Example

```swift

protocol Observer {
  var name: String { get }
  
  func handleEvent(vacancies: [String])
}

protocol Observed {
  mutating func addObserver(observer: Observer)
  mutating func removeObserver(observer: Observer)
  func notifyObservers()
}

struct Subscriber: Observer {
  var name: String
  
  func handleEvent(vacancies: [String]) {
    print("Dear \(name). We have some changes in vacancies:\n\(vacancies)\n")
  }
}

struct HeadHunter: Observed {
  var vacancies = [String]()
  var subscribers = [Observer]()
  
  mutating func addVacancy(vacancy: String) {
    vacancies.append(vacancy)
    notifyObservers()
  }
  
  mutating func removeVacancy(vacancy: String) {
    if let index = vacancies.index(of: vacancy) {
      vacancies.remove(at: index)
      notifyObservers()
    }
  }
  
  mutating func addObserver(observer: Observer) {
    subscribers.append(observer)
  }
  
  mutating func removeObserver(observer: Observer) {
    for index in 1...subscribers.count - 1 {
      let subscriber = subscribers[index]
      if subscriber.name == observer.name {
        subscribers.remove(at: index)
        break
      }
    }
  }
  
  func notifyObservers() {
    for subscriber in subscribers {
      subscriber.handleEvent(vacancies: vacancies)
    }
  }
}
```

### Usage

```swift

var hh = HeadHunter()
hh.addVacancy(vacancy: "Swift Developer")
hh.addVacancy(vacancy: "ObjC Developer")

let zsergey = Subscriber(name: "Sergey Zapuhlyak")
let azimin = Subscriber(name: "Alex Zimin")

hh.addObserver(observer: zsergey)
hh.addObserver(observer: azimin)

hh.addVacancy(vacancy: "C++ Developer")

hh.removeObserver(observer: azimin)
hh.removeVacancy(vacancy: "ObjC Developer")
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Observer)

```swift

```

🐉 State
---------

The state pattern is used to alter the behaviour of an object as its internal state changes.
The pattern allows the class for an object to apparently change at run-time.

### Example

```swift

protocol Activity {
  func justDoIt()
}

struct Coding: Activity {
  func justDoIt() {
    print("Writing code...")
  }
}

struct Reading: Activity {
  func justDoIt() {
    print("Reading book...")
  }
}

struct Sleeping: Activity {
  func justDoIt() {
    print("Sleeping...")
  }
}

struct Training: Activity {
  func justDoIt() {
    print("Training...")
  }
}

struct Developer {
  var activity: Activity
  
  mutating func changeActivity() {
    if let _ = activity as? Sleeping {
      activity = Training()
    } else if let _ = activity as? Training {
      activity = Coding()
    } else if let _ = activity as? Coding {
      activity = Reading()
    } else if let _ = activity as? Reading {
      activity = Sleeping()
    }
  }
  
  func justDoIt() {
    activity.justDoIt()
  }
}
```

### Usage

```swift

let activity = Sleeping()
var developer = Developer(activity: activity)
for i in 0..<10 {
  developer.justDoIt()
  developer.changeActivity()
}
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-State)

```swift

```

💡 Strategy
-----------

The strategy pattern is used to create an interchangeable family of algorithms from which the required process is chosen at run-time.

### Example

```swift

protocol Activity {
  func justDoIt()
}

struct Coding: Activity {
  func justDoIt() {
    print("Writing code...")
  }
}

struct Reading: Activity {
  func justDoIt() {
    print("Reading book...")
  }
}

struct Sleeping: Activity {
  func justDoIt() {
    print("Sleeping...")
  }
}

struct Training: Activity {
  func justDoIt() {
    print("Training...")
  }
}

struct Developer {
  var activity: Activity
  
  func executeActivity() {
    activity.justDoIt()
  }
}
```

### Usage

```swift

var developer = Developer(activity: Sleeping())
developer.executeActivity()

developer.activity = Training()
developer.executeActivity()

developer.activity = Coding()
developer.executeActivity()

developer.activity = Reading()
developer.executeActivity()

developer.activity = Sleeping()
developer.executeActivity()
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Strategy)

```swift

```

🐾 Template Method
----------

The template method pattern is used to define the program skeleton of an algorithm in an operation, deferring some steps to subclasses. It lets one redefine certain steps of an algorithm without changing the algorithm's structure.
 
### Example

```swift

protocol WebsiteTemplate {
  func showPageContent()
}

extension WebsiteTemplate {
  func showPage() {
    print("Header")
    showPageContent()
    print("Footer")
  }
}

struct WelcomePage: WebsiteTemplate {
  func showPageContent() {
    print("Welcome")
  }
}

struct NewsPage: WebsiteTemplate {
  func showPageContent() {
    print("News")
  }
}
```

### Usage

```swift

let welcomePage = WelcomePage()
welcomePage.showPage()
print("")

let newsPage = NewsPage()
newsPage.showPage()
```

Behavioral
==========

>In software engineering, behavioral design patterns are design patterns that identify common communication patterns between objects and realize these patterns. By doing so, these patterns increase flexibility in carrying out this communication.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Behavioral_pattern)

```swift

import Swift
import Foundation
```

🏃 Visitor
----------

The visitor pattern is used to separate a relatively complex set of structured data classes from the functionality that may be performed upon the data that they hold.

### Example

```swift

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
```

### Usage

```swift

let project = Project()
let junior = JuniorDeveloper()
let senior = SeniorDeveloper()

print("Junior in Action")
project.beWritten(developer: junior)

print("")

print("Senior in Action")
project.beWritten(developer: senior)
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Visitor)

```swift

```

🌰 Abstract Factory
-------------------

The abstract factory pattern is used to provide a client with a set of related or dependant objects. 
The "family" of objects created by the factory are determined at run-time.

### Example

```swift

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
```

### Usage

```swift

Projects.bankBusinessOnline.createProject()
Projects.auctionSite.createProject()
```

👷 Builder
----------

The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. 
An external class controls the construction algorithm.

### Example

```swift

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
```

### Usage

```swift

let director = Director(builder: EnterpriseWebsiteBuilder())
let website = director.buildWebsite()
website.printWebsite()
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Builder)

```swift

```

🏭 Factory Method
-----------------

The factory pattern is used to replace class constructors, abstracting the process of object generation so that the type of the object instantiated can be determined at run-time.

### Example

```swift

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
```

### Usage

```swift

let developer = Languages.swift.factory.newDeveloper()
developer.writeCode()
```

🃏 Prototype
------------

The prototype pattern is used to instantiate a new object by copying all of the properties of an existing object, creating an independent clone. 
This practise is particularly useful when the construction of a new object is inefficient.

### Example

```swift

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
```

### Usage

```swift

let master = Project(id: 1, name: "Playground.swift", source: "let sourceCode = SourceCode()")
let factory = ProjectFactory(project: master)
let masterClone = factory.cloneProject()
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Prototype)

```swift

```

💍 Singleton
------------

The singleton pattern ensures that only one object of a particular class is ever created.
All further references to objects of the singleton class refer to the same underlying instance.
There are very few applications, do not overuse this pattern!

### Example:

```swift

struct Game {
  static let sharedGame = Game()
  
  private init() {
    
  }
}
```

### Usage:

```swift

let game = Game.sharedGame
```

Creational
==========

> In software engineering, creational design patterns are design patterns that deal with object creation mechanisms, trying to create objects in a manner suitable to the situation. The basic form of object creation could result in design problems or added complexity to the design. Creational design patterns solve this problem by somehow controlling this object creation.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Creational_pattern)

```swift

import Swift
import Foundation
```

🔌 Adapter
----------

The adapter pattern is used to provide a link between two otherwise incompatible types by wrapping the "adaptee" with a class that supports the interface required by the client.

### Example

```swift

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
```

### Usage

```swift

let databaseManager = DatabaseManager(database: AdapterSwiftAppToDatabase())
databaseManager.run()
```

>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Adapter)

```swift

```

🌉 Bridge
----------

The bridge pattern is used to separate the abstract elements of a class from the implementation details, providing the means to replace the implementation details without modifying the abstraction.

### Example

```swift

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
```

### Usage

```swift

let programs: [Program] = [BankSystem(developer: ObjCDeveloper()),
                           StockExchange(developer: SwiftDeveloper())]
for program in programs {
  program.develop()
}
```

🌿 Composite
-------------

The composite pattern is used to create hierarchical, recursive tree structures of related objects where any element of the structure may be accessed and utilised in a standard manner.

### Example

```swift

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
```

### Usage:

```swift

let team = BankTeam()
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: ObjCDeveloper())
team.addDeveloper(developer: SwiftDeveloper())
team.createProject()
```

🍧 Decorator
------------

The decorator pattern is used to extend or alter the functionality of objects at run- time by wrapping them in an object of a decorator class. 
This provides a flexible alternative to using inheritance to modify behaviour.

### Example

```swift

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
```

### Usage:

```swift

let developer = SwiftTeamLead(developer: SeniorSwiftDeveloper(developer: SwiftDeveloper()))
print(developer.makeJob())
```

🎁 Façade
---------

The facade pattern is used to define a simplified interface to a more complex subsystem.

### Example

```swift

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
```

### Usage

```swift

let workflow = Workflow()
workflow.solveProblems()
```

## 🍃 Flyweight
The flyweight pattern is used to minimize memory usage or computational expenses by sharing as much as possible with other similar objects.
### Example

```swift

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
```

### Usage

```swift

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
```

☔ Proxy
------------------

The proxy pattern is used to provide a surrogate or placeholder object, which references an underlying object. 

### Example

```swift

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
```

### Usage

```swift

var project = ProxyProject(url: "https://github.com/zsergey/realProject")
project.run()
```

Structural
==========

>In software engineering, structural design patterns are design patterns that ease the design by identifying a simple way to realize relationships between entities.
>
>**Source:** [wikipedia.org](http://en.wikipedia.org/wiki/Structural_pattern)

```swift

import Swift
import Foundation
```


Info
====

📖 Descriptions from: [Gang of Four Design Patterns Reference Sheet](http://www.blackwasp.co.uk/GangOfFour.aspx)


```swift
