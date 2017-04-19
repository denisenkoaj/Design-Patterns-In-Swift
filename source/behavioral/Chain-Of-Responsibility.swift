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
