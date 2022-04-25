//
//  ViewController.swift
//  SimpleHangmanGame
//
//  Created by John Salvador on 4/24/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var wordToGuessLabel: UILabel!
    @IBOutlet weak var remainingLifeLabel: UILabel!
    
    // MARK: - Stored Properties
    var hangmanGame: HangmanGame?
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(prepareHangmanGame), with: nil)
    }
    
    
    // MARK: - Private Methods
    private func updateWordToGuessLabel() {
        self.wordToGuessLabel.text = self.hangmanGame?.displayText
    }
    
    func updateLifeCount() {
        self.remainingLifeLabel.text = "\(self.hangmanGame?.lifeCountText ?? "nil")"
    }
    
    @objc
    func prepareHangmanGame() {
        if let path = Bundle.main.url(forResource: "hangmanwords", withExtension: "txt") {
            do {
                let words = try String(contentsOf: path).components(separatedBy: "\n")
                
                // Initialize Hangman Game
                hangmanGame = HangmanGame(words: words)
                hangmanGame?.startNewGame()
                
                DispatchQueue.main.async {
                    self.updateUI()
                }
            } catch {
                print("Failed to get the words for the game")
            }
        }
    }
    
    func presentRoundCompletedAlert(_ wonRound: Bool) {
        var title = ""
        var message = ""
        
        if wonRound {
            title = "You won this round."
            message = "Up for next word to guess?"
        } else {
            title = "You lose this round."
            message = "Wanna play another round?"
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            // Play another round
            self.hangmanGame?.startNewGame()
            self.updateUI()
        }
        
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        present(ac, animated: true)
    }
    
    func updateUI() {
        self.updateWordToGuessLabel()
        self.updateLifeCount()
    }
    
    // MARK: - IBactions
    @IBAction func guessButtonTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Enter single character", message: nil, preferredStyle: .alert)
        ac.addTextField { textfield in
            textfield.delegate = self
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let guessAction = UIAlertAction(title: "Guess", style: .default) { _ in
            if let chosenLetter = ac.textFields?[0].text, !chosenLetter.isEmpty {
                guard self.hangmanGame != nil else { return }
                self.hangmanGame!.guessLetter(letter: Character(chosenLetter), onCorrectGuess: {
                    self.updateWordToGuessLabel()
                }, onIncorrectGuess: {
                    self.updateLifeCount()
                }) { wordGuessed in
                    self.presentRoundCompletedAlert(wordGuessed)
                }
            }
        }
        
        ac.addAction(cancelAction)
        ac.addAction(guessAction)
        
        present(ac, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 1
    }
}
