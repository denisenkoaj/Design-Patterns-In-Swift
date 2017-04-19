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
