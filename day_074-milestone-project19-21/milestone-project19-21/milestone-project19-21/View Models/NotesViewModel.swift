//
//  NotesViewModel.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation


struct NotesViewModel {
    
    // MARK: - Properties
    let notes: [Note]
    
    // MARK: -
    var numberOfNotes: Int {
        return notes.count
    }
    
    func viewModel(for index: Int) -> NoteViewModel {
        return NoteViewModel(note: notes[index])
    }
    
    func createNewNote() -> Note {
        return Note()
    }
    
}
