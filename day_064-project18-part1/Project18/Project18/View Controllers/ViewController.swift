//
//  ViewController.swift
//  Project18
//
//  Created by John Salvador on 5/15/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 1...100 {
            print("Got number \(i)")
        }
        
//        fatalError("TEST")
        NSException(name:NSExceptionName(rawValue: "name"), reason:"reason", userInfo:nil).raise()
    }
    
    // MARK: - Helper Method
    private func testDebuggingMethods() {
        // `print` debugging method - a method where everyone starts
        print("I'm inside the viewDidLoad() method!")
        
        // `print` fuction can accept multiple values too which makes it a Variadic function
        print(1, 2, 3, 4, 5)
        
        // `print` function has extra parameters too that you can use which is `separator` and `terminator`
        
        // Using separator
        print(1, 2, 3, 4, 5, separator: "-")
        
        // Using terminator
        print("Some Message", terminator: "--") // default value of `terminator` is a line break or "\n"
        print("Another Message", terminator: "") // giving `terminator` a no value means there will be no line break for next print
        
        
        // Assertion
        assert(1 == 1, "Math failure!")
        assert(1 == 2, "Math Failure!") // This will make your app crash
    }
}

