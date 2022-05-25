//
//  DetailViewController.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.becomeFirstResponder()
        }
    }
    
    // MARK: - Properties
    private var viewModel: NoteViewModel
    weak var notesVCdelegate: NotesViewControllerDelegate?
    
    private var isANewNote: Bool {
        return viewModel.isANewNote
    }
    
    // MARK: - Init
    init?(coder: NSCoder, viewModel: NoteViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:country:)` to initialize an `DetailViewController` instance.")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DetailViewController.handleKeyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DetailViewController.handleKeybolardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Helper Methods
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        setupContents()
    }
    
    private func setupContents() {
        self.contentTextView.text = viewModel.contentWithTitle
    }
    
    private func prepareContentToSave() -> (title: String, content: String)? {
        var allContent = contentTextView.text.components(separatedBy: "\n")
        
        guard !allContent.isEmpty else {
            // Nothing to save
            print("Nothing to save")
            return nil
        }
        
        // Remove the first line as title from the textview and save it
        let contentTitle = allContent.removeFirst()
        
        // The rest is the content from the text view
        let content = allContent.joined(separator: "\n")
        
        return (contentTitle, content)
    }
    
    private func updateNote(with title: String, content: String) {
        viewModel.updateNote(with: title, content: content)
        
        guard let index = viewModel.selectedIndex else {
            fatalError("No Selected Index")
        }
        
        notesVCdelegate?.didUpdateNote(note: viewModel.note, at: index)
    }
    
    private func addNewNote(with title: String, content: String) {
        viewModel.updateNote(with: title, content: content)
        
        notesVCdelegate?.didCreateNewNote(note: viewModel.note)
    }
}

// MARK: - Actions
extension DetailViewController {
    @objc private func doneButtonPressed(_ sender: UIBarButtonItem? = nil) {
        guard let (contentTitle, content) = prepareContentToSave() else {
            return
        }
        
        if isANewNote {
            addNewNote(with: contentTitle, content: content)
        } else {
            // Update the note
            updateNote(with: contentTitle, content: content)
        }
        
        // Pop VC
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleKeyboardDidShow(notification: NSNotification) {
        guard let keyboardRect = notification
            .userInfo![UIResponder.keyboardFrameEndUserInfoKey]
                as? NSValue else { return }
        
        let frameKeyboard = keyboardRect.cgRectValue
        
        contentTextView.contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: frameKeyboard.size.height,
            right: 0.0
        )
        
        view.layoutIfNeeded()
    }
    
    @objc func handleKeybolardWillHide() {
        contentTextView.contentInset = .zero
    }
}
