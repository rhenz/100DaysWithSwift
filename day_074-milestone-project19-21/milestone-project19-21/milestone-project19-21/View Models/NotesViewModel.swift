//
//  NotesViewModel.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation


struct NotesViewModel {
    
    // MARK: - Properties
    private(set) var notes: [Note]
    
    
    var numberOfNotes: Int {
        return notes.count
    }
    
    
    // MARK: - Init
    init() {
        notes = []
        
        // Retrieve notes
        retrieveNotes()
    }
    
    // MARK: -
    
    func viewModel(for index: Int) -> NoteViewModel {
        return NoteViewModel(note: notes[index], selectedIndex: index)
    }
    
    mutating func updateNote(note: Note, at index: Int) {
        self.notes[index] = note
    }
    
    mutating func addNewNote(note: Note) {
        self.notes.append(note)
    }
    
    func saveNotes() {
        Storage.store(notes, to: .notes, as: Constants.FileName.notesJson)
    }
    
    private mutating func retrieveNotes() {
        if Storage.fileExists(Constants.FileName.notesJson, in: .notes) {
            notes =  Storage.retrieve(Constants.FileName.notesJson, from: .notes, as: [Note].self)
        } else {
            // Initialize notes with empty arrays
            notes = []
        }
    }
}
