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
🐝 Chain Of Responsibility
--------------------------

The chain of responsibility pattern is used to process varied requests, each of which may be dealt with by a different handler.

### Example:
*/
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
/*:
### Usage
*/
let smsNotifier = SMSNotifier(nextNotifier: nil, priority: Priority.asSoonAsPossible.hashValue)
let emailNotifier = EmailNotifier(nextNotifier: smsNotifier, priority: Priority.important.hashValue)
let reportNotifier = SimpleReportNotifier(nextNotifier: emailNotifier, priority: Priority.routine.hashValue)

reportNotifier.notifyManager(message: "Everything is OK", level: Priority.routine.hashValue)
reportNotifier.notifyManager(message: "Something went wrong", level: Priority.important.hashValue)
reportNotifier.notifyManager(message: "Houston, we've had a problem here!", level: Priority.asSoonAsPossible.hashValue)
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Chain-Of-Responsibility)
*/
/*:
👫 Command
----------

The command pattern is used to express a request, including the call to be made and all of its required parameters, in a command object. The command may then be executed immediately or held for later use.

### Example:
*/
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
/*:
### Usage:
*/
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
/*:
🎶 Interpreter
--------------

The interpreter pattern is used to evaluate sentences in a language.

### Example
*/
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
/*:
### Usage
*/
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
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Interpreter)
*/
/*:
🍫 Iterator
-----------

The iterator pattern is used to provide a standard interface for traversing a collection of items in an aggregate object without the need to understand its underlying structure.

### Example:
*/
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
/*:
### Usage
*/
let skills = ["Swift", "ObjC", "Sketch", "PM"]
let swiftDeveloper = SwiftDeveloper(name: "Sergey Zapuhlyak", skills: skills)
var iterator = swiftDeveloper.getIterator()
print("Developer \(swiftDeveloper.name)")
print("Skills")
while iterator.hasNext() {
  print("\(iterator.next())")
}
/*:
💐 Mediator
-----------

The mediator pattern is used to reduce coupling between classes that communicate with each other. Instead of classes communicating directly, and thus requiring knowledge of their implementation, the classes send messages via a mediator object.

### Example
*/
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
/*:
### Usage
*/
var telegram = Telegram()
let admin = Admin(ID: 1, name: "Pavel Durov", chat: telegram)
let zsergey = Client(ID: 2, name: "Sergey Zapuhlyak", chat: telegram)
let azimin = Client(ID: 3, name: "Alex Zimin", chat: telegram)
telegram.admin = admin
telegram.addClient(client: zsergey)
telegram.addClient(client: azimin)

zsergey.sendMessage("Hello, I am Sergey Zapuhlyak")
admin.sendMessage("I am Administrator!")
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Mediator)
*/
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
/*:
👓 Observer
-----------

The observer pattern is used to allow an object to publish changes to its state.
Other objects subscribe to be immediately notified of any changes.

### Example
*/
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
/*:
### Usage
*/
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
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Observer)
*/
/*:
🐉 State
---------

The state pattern is used to alter the behaviour of an object as its internal state changes.
The pattern allows the class for an object to apparently change at run-time.

### Example
*/
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
/*:
### Usage
*/
let activity = Sleeping()
var developer = Developer(activity: activity)
for i in 0..<10 {
  developer.justDoIt()
  developer.changeActivity()
}
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-State)
*/
/*:
💡 Strategy
-----------

The strategy pattern is used to create an interchangeable family of algorithms from which the required process is chosen at run-time.

### Example
*/
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
/*:
### Usage
*/
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
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Strategy)
*/
/*:
🐾 Template Method
----------

The template method pattern is used to define the program skeleton of an algorithm in an operation, deferring some steps to subclasses. It lets one redefine certain steps of an algorithm without changing the algorithm's structure.
 
### Example
*/
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
/*:
### Usage
*/
let welcomePage = WelcomePage()
welcomePage.showPage()
print("")

let newsPage = NewsPage()
newsPage.showPage()
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
