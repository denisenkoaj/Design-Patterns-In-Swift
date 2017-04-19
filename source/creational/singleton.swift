/*:
💍 Singleton
------------

The singleton pattern ensures that only one object of a particular class is ever created.
All further references to objects of the singleton class refer to the same underlying instance.
There are very few applications, do not overuse this pattern!

### Example:
*/
struct Game {
  static let sharedGame = Game()
  
  private init() {
    
  }
}
/*:
### Usage:
*/
let game = Game.sharedGame
