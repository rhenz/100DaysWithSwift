//
//  NotesViewController.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import UIKit

protocol NoteRepresentable {
    var title: String { get }
    var date: String { get }
    var content: String { get }
    var image: UIImage? { get }
}

class NotesViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel = NotesViewModel(notes: Note.testData)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Helper Methods
    private func setupViews() {
        // Register Notes Cell to Table View
        tableView.register(NoteCell.nib, forCellReuseIdentifier: NoteCell.identifier)
        
        // Add Bar Button Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNewNote))
    }
    
    private func setupViewModel(with viewModel: NotesViewModel) {
        
        // Update table view
        tableView.reloadData()
    }
    
    private func showDetailVC(_ note: Note? = nil) {
        let noteToShow = note == nil ? self.viewModel.createNewNote() : note!
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: DetailViewController.storyboardIdentifier, creator: { coder -> DetailViewController? in
            DetailViewController(coder: coder, viewModel: NoteViewModel(note: noteToShow))
        })
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Actions
extension NotesViewController {
    @objc private func createNewNote() {
        
    }
}

// MARK: - Table View Data Source
extension NotesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNotes
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell else {
            fatalError("Failed to dequeue reusable cell.") // This should not happen
        }
        
        // Setup Cell
        cell.configure(with: viewModel.viewModel(for: indexPath.item))
        return cell
    }
}

// MARK: - Table View Delegate
extension NotesViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetailVC()
    }
}
