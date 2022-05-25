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
    
    // MARK: -
    var numberOfNotes: Int {
        return notes.count
    }
    
    func viewModel(for index: Int) -> NoteViewModel {
        return NoteViewModel(note: notes[index], selectedIndex: index)
    }
    
    func createNewNote() -> Note {
        return Note()
    }
    
    mutating func updateNote(note: Note, at index: Int) {
        self.notes[index] = note
    }
    
    mutating func addNewNote(note: Note) {
        self.notes.append(note)
    }
    
}
