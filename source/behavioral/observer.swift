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
