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
