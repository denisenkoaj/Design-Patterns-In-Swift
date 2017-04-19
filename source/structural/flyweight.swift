/*:
## 🍃 Flyweight
The flyweight pattern is used to minimize memory usage or computational expenses by sharing as much as possible with other similar objects.
### Example
*/
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
/*:
### Usage
*/
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
