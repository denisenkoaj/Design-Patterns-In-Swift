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
