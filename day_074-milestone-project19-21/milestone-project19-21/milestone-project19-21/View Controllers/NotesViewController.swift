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

protocol NotesViewControllerDelegate: AnyObject {
    func didUpdateNote(note: Note, at index: Int)
    func didCreateNewNote(note: Note)
}

class NotesViewController: UITableViewController {
    
    // MARK: - Properties
    var viewModel = NotesViewModel(notes: [])

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
    
    private func showDetailVC(_ noteViewModel: NoteViewModel? = nil) {
        if let noteViewModel = noteViewModel {
            // Show Existing Note
            let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: DetailViewController.storyboardIdentifier, creator: { coder -> DetailViewController? in
                DetailViewController(coder: coder, viewModel: noteViewModel)
            })
            detailVC.notesVCdelegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        } else {
            // Create New Note
            let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: DetailViewController.storyboardIdentifier, creator: { coder -> DetailViewController? in
                DetailViewController(coder: coder, viewModel: NoteViewModel(note: Note()))
            })
            detailVC.notesVCdelegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // TODO: Save notes to Files
    private func saveNotes() {
        
    }
}

// MARK: - Actions
extension NotesViewController {
    @objc private func createNewNote() {
        showDetailVC()
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
        showDetailVC(viewModel.viewModel(for: indexPath.item))
    }
}


// MARK: -
extension NotesViewController: NotesViewControllerDelegate {
    func didUpdateNote(note: Note, at index: Int) {
        // Update Note
        viewModel.updateNote(note: note, at: index)
        
        // Update Table View
        tableView.reloadData()
    }
    
    func didCreateNewNote(note: Note) {
        // Add New Note
        viewModel.addNewNote(note: note)
        
        // Update Table View
        tableView.reloadData()
    }
}
