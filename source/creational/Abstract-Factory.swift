/*:
🌰 Abstract Factory
-------------------

The abstract factory pattern is used to provide a client with a set of related or dependant objects. 
The "family" of objects created by the factory are determined at run-time.

### Example
*/
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
/*:
### Usage
*/
Projects.bankBusinessOnline.createProject()
Projects.auctionSite.createProject()
