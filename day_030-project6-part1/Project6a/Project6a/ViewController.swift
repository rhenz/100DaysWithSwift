//
//  ViewController.swift
//  Project6a
//
//  Created by JLCS on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // MARK: - Store Properties
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestionCount = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        setupViews()
        askQuestion()
    }

    // MARK: - Private Methods
    private func setupViews() {
//        self.button1.layer.borderWidth = 1
//        self.button2.layer.borderWidth = 1
//        self.button3.layer.borderWidth = 1
//        
//        self.button1.layer.borderColor = UIColor.lightGray.cgColor
//        self.button2.layer.borderColor = UIColor.lightGray.cgColor
//        self.button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showScore))
    }
    
    @objc
    private func showScore() {
        let ac = UIAlertController(title: "Score", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    private func askQuestion(_ alertAction: UIAlertAction? = nil) {
        self.countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        askedQuestionCount += 1
        self.title = "\(countries[correctAnswer].uppercased()) Score: \(self.score)"
    }
    
    private func presentWrongFlagAlert(_ country: String, alertPresented: @escaping () -> ()) {
        let ac = UIAlertController(title: "Wrong Flag", message: "That's the flag of \(country)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alertPresented()
        }
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
    private func presentGameCompleteAlert() {
        let title = "Game Complete"
        let ac = UIAlertController(title: title, message: "Your score is \(self.score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
        
        self.title = "Game Complete - Score: \(self.score)"
        
        // Disable all buttons
        shouldEnableCountryButtons(false)
    }
    
    private func restartGame() {
        score = 0
        correctAnswer = 0
        askedQuestionCount = 0
        shouldEnableCountryButtons(true)
        askQuestion()
    }
    
    private func shouldEnableCountryButtons(_ enable: Bool) {
        if enable {
            button1.isUserInteractionEnabled = true
            button2.isUserInteractionEnabled = true
            button3.isUserInteractionEnabled = true

            button1.alpha = 1
            button2.alpha = 1
            button3.alpha = 1
            
            playAgainButton.isHidden = true
        } else {
            button1.isUserInteractionEnabled = false
            button2.isUserInteractionEnabled = false
            button3.isUserInteractionEnabled = false

            button1.alpha = 0.3
            button2.alpha = 0.3
            button3.alpha = 0.3
            
            playAgainButton.isHidden = false
        }
    }
    
    private func checkIfGameCompleted() {
        if self.askedQuestionCount == 10 {
            self.presentGameCompleteAlert()
        } else {
            self.askQuestion()
        }
    }
    
    // MARK: - IBActions
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        restartGame()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            self.score += 1
            self.checkIfGameCompleted()
        } else {
            if self.score > 0 { self.score -= 1 }
            presentWrongFlagAlert(self.countries[sender.tag].uppercased()) {
                self.checkIfGameCompleted()
            }
        }
    }
}

