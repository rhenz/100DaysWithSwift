//
//  ViewController.swift
//  Project2
//
//  Created by JLCS on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    // MARK: - Store Properties
    var countries = [String]()
    var score = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.button1.layer.borderWidth = 1
        self.button2.layer.borderWidth = 1
        self.button3.layer.borderWidth = 1
        
        self.button1.layer.borderColor = UIColor.lightGray.cgColor
        self.button2.layer.borderColor = UIColor.lightGray.cgColor
        self.button3.layer.borderColor = UIColor.lightGray.cgColor

        
        self.countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }

    // MARK: - Private Methods
    private func askQuestion() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
}

