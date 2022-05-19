//
//  ActionViewController.swift
//  Extension
//
//  Created by John Salvador on 5/17/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var script: UITextView!
    
    // MARK: - Properties
    var pageTitle = ""
    var pageURL = ""
    
    private var storedScriptsByURL: [String: String] = [:]
    private var storedScriptsByURLKey = "storedScriptsByURLKey"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedScript()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // Create Navigation Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Scripts", style: .plain, target: self, action: #selector(selectAvailableScripts))
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: UTType.propertyList.identifier) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                    
                    let urlStr = javaScriptValues["URL"] as? String ?? "www.apple.com"
                    if let url = URL(string: urlStr) {
                        DispatchQueue.main.async {
                            self?.script.text = self?.storedScriptsByURL[url.host!]
                        }
                    }
                    
                }
            }
        }
        
        
    }
    
    // MARK: - Methods
    private func saveJSforEachSite(_ url: String) {
        if let url = URL(string: url), let host = url.host {
            storedScriptsByURL[host] = script.text ?? ""
            
            // Save to User Defaults // Challenge #2
            let defaults = UserDefaults.standard
            defaults.set(storedScriptsByURL, forKey: storedScriptsByURLKey)
        }
    }
    
    private func loadSavedScript() {
        let defaults = UserDefaults.standard
        if let dict = defaults.object(forKey: storedScriptsByURLKey) as? [String: String] {
            storedScriptsByURL = dict
        }
    }
    
    @objc func done(_ sender: UIBarButtonItem) {
        executeScript()
    }
    
    private func executeScript(_ jsScript: String? = nil) {
        let item = NSExtensionItem()
        let _script = script.text.isEmpty ? jsScript : script.text
        let argument: NSDictionary = ["customJavaScript": _script ?? ""]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: UTType.propertyList.identifier)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        
        // # CHallenge 2
        saveJSforEachSite(self.pageURL)
    }
    
    private func addScriptToScriptTextView(_ script: String) {
        self.script.text = script
    }
    
    @objc func selectAvailableScripts(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Prewritten Example Scripts", message: nil, preferredStyle: .actionSheet)
        
        let presentWebTitleAlert = UIAlertAction(title: "Show Website Title", style: .default) { [weak self] _ in
            // Add Javascript code on text view
            let script =
            """
            alert(document.title);
            """
            
//            self?.addScriptToScriptTextView(script)
            self?.executeScript(script)
        }
        
        let presentHelloWorldAlert = UIAlertAction(title: "Show Hello World Alert", style: .default) { [weak self] _ in
            // Add Javascript code on text view
            let script =
            """
            alert("Hello World!");
            """
            
//            self?.addScriptToScriptTextView(script)
            self?.executeScript(script)
        }
        
        let presentPromptBox = UIAlertAction(title: "Show Prompt Box", style: .default) { [weak self] _ in
            // Add Javascript code on text view
            let script =
            """
            let person = prompt("Please enter your name", "Harry Potter");
            let text;
            if (person == null || person == "") {
              text = "User cancelled the prompt.";
            } else {
              text = "Hello " + person + "! How are you today?";
            }
            
            alert(text);
            """
            
//            self?.addScriptToScriptTextView(script)
            self?.executeScript(script)
        }
        
        actionSheet.addAction(presentWebTitleAlert)
        actionSheet.addAction(presentHelloWorldAlert)
        actionSheet.addAction(presentPromptBox)
        
        present(actionSheet, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        script.scrollIndicatorInsets = script.contentInset

        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
}























// MARK: -
/*
extension ActionViewController {
    private func originalCodeInViewDidLoad() {
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! {
                if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakImageView = self.imageView
                    provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil, completionHandler: { (imageURL, error) in
                        OperationQueue.main.addOperation {
                            if let strongImageView = weakImageView {
                                if let imageURL = imageURL as? URL {
                                    strongImageView.image = UIImage(data: try! Data(contentsOf: imageURL))
                                }
                            }
                        }
                    })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }
}
*/
