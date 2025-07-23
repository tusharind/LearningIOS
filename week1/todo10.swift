//To-do #10

    //Create a class with properties, methods, and inheritance

    class Developer {  //parent class
        var name: String
        var experience: Int // in years
        
        init(name: String, experience: Int) {
            self.name = name
            self.experience = experience
        }
        
        func code() {
            print("\(name) is a developer with \(experience) years of experience")
        }
        
    }
    
    class IOSDeveloper: Developer { //subclass of parent class developer
        var favoriteFramework: String
        
        init(name: String, experience: Int, favoriteFramework: String) {
            self.favoriteFramework = favoriteFramework
            super.init(name: name, experience: experience)
        }
        
        override func code() {
            print("\(name) works with \(favoriteFramework)")
        }
        
        func buildApp() {
            print("\(name) just built an iOS app using \(favoriteFramework).")
        }
    }
      
let iosDev = IOSDeveloper(name: "Anu", experience: 0, favoriteFramework: "SwiftUI");
  IosDev.code()  
 IosDev.buildApp()


