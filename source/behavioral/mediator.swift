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
