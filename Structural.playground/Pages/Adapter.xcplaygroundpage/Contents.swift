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
