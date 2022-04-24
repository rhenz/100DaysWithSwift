//
//  HangmanGame.swift
//  SimpleHangmanGame
//
//  Created by John Salvador on 4/24/22.
//

import Foundation

class HangmanGame {
    private var words: [String] // Will never be empty
    private var wordToGuess: String = ""
    private var usedLetters: [Character] = []
    private var lifeCount = 7
    
    var displayText: String {
        var text = ""
        for letter in wordToGuess {
            if usedLetters.contains(letter) {
                text += String(letter)
            } else {
                text += "?"
            }
        }
        
        return text
    }
    
    var lifeCountText: String {
        return "\(lifeCount)"
    }
    
    // MARK: - Init
    init?(words: [String]) {
        guard !words.isEmpty else { return nil }
        self.words = words
    }
    
    // MARK: - Methods
    func guessLetter(letter: Character,
                     onCorrectGuess: () -> Void,
                     onIncorrectGuess: () -> Void,
                     onGameFinished: (_ wordGuessed: Bool) -> Void)
    {
        if wordToGuess.contains(letter) {
            usedLetters.append(letter)
            onCorrectGuess()
            
            if displayText == wordToGuess {
                onGameFinished(true)
            }
        } else {
            lifeCount -= 1
            onIncorrectGuess()
            
            if lifeCount == 0 {
                onGameFinished(false)
            }
        }
    }
    
    func startNewGame() {
        lifeCount = 7
        usedLetters.removeAll()
        wordToGuess = words.randomElement()!
        print(wordToGuess)
    }
}
