/*:
👷 Builder
----------

The builder pattern is used to create complex objects with constituent parts that must be created in the same order or using a specific algorithm. 
An external class controls the construction algorithm.

### Example
*/
enum Cms {
  case wordpress
  case alifresco
}

struct Website {
  var name: String?
  var cms: Cms?
  var price: Int?
  
  func printWebsite(){
    guard let name = name, let cms = cms, let price = price else {
      return
    }
    print("Name \(name), cms \(cms), price \(price)")
  }
}

protocol WebsiteBuilder {
  var website: Website? { set get }
  func createWebsite()
  func buildName()
  func buildCms()
  func buildPrice()
}

class VisitCardWebsiteBuilder: WebsiteBuilder {
  internal var website: Website?
  
  internal func createWebsite() {
    self.website = Website()
  }
  
  internal func buildName() {
    self.website?.name = "Visit Card"
  }
  
  internal func buildCms() {
    self.website?.cms = .wordpress
  }
  
  internal func buildPrice() {
    self.website?.price = 500
  }
}

class EnterpriseWebsiteBuilder: WebsiteBuilder {
  internal var website: Website?
  
  internal func createWebsite() {
    self.website = Website()
  }
  
  internal func buildName() {
    self.website?.name = "Enterprise website"
  }
  
  internal func buildCms() {
    self.website?.cms = .alifresco
  }
  
  internal func buildPrice() {
    self.website?.price = 10000
  }
}

struct Director {
  var builder: WebsiteBuilder
  
  func buildWebsite() -> Website {
    builder.createWebsite()
    builder.buildName()
    builder.buildCms()
    builder.buildPrice()
    return builder.website!
  }
}
/*:
### Usage
*/
let director = Director(builder: EnterpriseWebsiteBuilder())
let website = director.buildWebsite()
website.printWebsite()
/*:
>**Further Examples:** [Design Patterns in Swift](https://github.com/kingreza/Swift-Builder)
*/
