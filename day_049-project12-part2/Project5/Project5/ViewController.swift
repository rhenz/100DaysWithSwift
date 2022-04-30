//
//  ViewController.swift
//  Project5
//
//  Created by JLCS on 4/9/22.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Stored Properties
    var allWords: [String] = []
    var usedWords: [String] = []
    var gameState: GameState?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        setupView()
        setupGame()
        startGame()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startNewGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
    }
    
    private func setupGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let gameStateData = defaults.object(forKey: "gameState") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                gameState = try jsonDecoder.decode(GameState.self, from: gameStateData)
            } catch {
                print("Failed to load storms")
            }
        }
    }
    
    func save() {
        let jsonDecoder = JSONEncoder()
        if let savedData = try? jsonDecoder.encode(gameState) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "gameState")
        } else {
            print("Failed to save gameState")
        }
    }
    
    func removeGameState() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "gameState")
    }
    
    private func startGame() {
        if let state = gameState {
            self.title = state.word
            usedWords = state.entries
            tableView.reloadData()
        } else {
            self.title = allWords.randomElement()
        }
    }
    
    @objc
    private func startNewGame() {
        removeGameState()
        self.title = allWords.randomElement()
        usedWords.removeAll()
        tableView.reloadData()
    }
    
    @objc
    private func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer).bool {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    updateGameState()
                    
                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
            }
        } else {
            if let error = isPossible(word: lowerAnswer).error {
                showErrorMessage(errorTitle: error.errorTitle, errorMessage: error.errorMessage)
                return
            }
            
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title)")
        }
    }
    
    func updateGameState() {
        if let wordTitle = self.title, gameState == nil {
            gameState = GameState(word: wordTitle, entries: usedWords)
        } else {
            gameState?.entries = usedWords
        }
        
        save()
    }
    
    func isPossible(word: String) -> (error: (errorTitle: String, errorMessage: String)?, bool: Bool) {
        // Check if word count is less than 3
        if word.utf16.count < 3 {
            return (
                (errorTitle: "Word less than 3 characters",
                 errorMessage: "You can't enter words less than 3 characters"),
                false)
        }
        
        // Input word should not be the same as the start word
        if word == self.title {
            return (
                (errorTitle: "Word same as Start Word",
                 errorMessage: "You can't enter words same with the Start Word"),
                false)
        }
        
        guard var tempWord = title?.lowercased() else { return (nil, false) }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return (nil, false)
            }
        }
        
        return (nil, true)
    }
    
    func isOriginal(word: String) -> Bool {
        //        return !usedWords.contains(where: {$0.caseInsensitiveCompare(word) == .orderedSame})
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

// MARK: - Table View Data Source
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row].capitalized
        return cell
    }
}

// MARK: - Table View Delegate
extension ViewController {
    
}

