import UIKit

var greeting = "Hello, playground"

class First {
    func firstFUnc(handler: (()->()) ) {}

    func secondFUnc(handler: (()->()) ) {
        DispatchQueue.main.async {
            self.firstFUnc(handler: handler)
        }
    }

}
