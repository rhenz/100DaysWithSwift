//
//  ViewController.swift
//  Project28
//
//  Created by John Salvador on 6/9/22.
//

import UIKit
import SwiftKeychainWrapper
import LocalAuthentication

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var secret: UITextView!
    
    // Challenge #1
    private var isLocked: Bool = true {
        didSet {
            if isLocked {
                secret.isHidden = true
                navigationItem.rightBarButtonItem = nil
            } else {
                secret.isHidden = false
                navigationItem.rightBarButtonItem = lockBarButtonItem
            }
        }
    }
    
    // MARK: - Properties
    private lazy var lockBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "lock.fill"), style: .plain, target: self, action: #selector(saveSecretMessage))
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDefaultPassword()
        setupObservers()
    }
    
    // MARK: - Helper Methods
    
    private func setupDefaultPassword() {
        if !KeychainWrapper.standard.hasValue(forKey: "MyPassword") {
            KeychainWrapper.standard.set("password", forKey: "MyPassword")
        }
    }
    
    private func setupViews() {
        // Set Navigation Bar Title
        title = "Nothing to see here"
    }
    
    private func setupObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Save secret message whenever the app goes in background
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func unlockSecretMessage() {
        isLocked = false
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            secret.text = text
        }
    }
    
    @objc private func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        isLocked = true
        title = "Nothing to see here"
    }
    
}

// MARK: - Actions

extension ViewController {
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    @IBAction func authenticateTapped(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // Challenge #2
            let ac = UIAlertController(title: "Enter Password", message: nil, preferredStyle: .alert)
            ac.addTextField { textField in
                textField.isSecureTextEntry = true
            }
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                guard let text = ac.textFields?.first?.text else { return }
                
                // Check if password in textfield is correct
                if text == KeychainWrapper.standard.string(forKey: "MyPassword") {
                    // Unlock Secret Message
                    self.unlockSecretMessage()
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            ac.addAction(okAction)
            ac.addAction(cancelAction)
            self.present(ac, animated: true)
        }
    }
}

