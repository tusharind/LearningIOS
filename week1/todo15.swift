//TODO 15: Create a Protocol and Implement It in Different Types (with mutating method)


protocol Superhero {
    mutating func superPowers()
}
struct Spiderman: Superhero {
    var canFly = false
    mutating func superPowers() {
         print("it can climb tall buildings")
    }
}
enum AntMan: Superhero {
    case big,small
    mutating func superPowers() {
        self = (self == .big) ? .small : .big

  print("AntMan is now \(self).")
    }
  
}

