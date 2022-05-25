//
//  NoteViewModel.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation
import UIKit

//let test = NoteViewModel(

struct NoteViewModel {
    
    // MARK: - Properties
    private(set) var note: Note
    private(set) var selectedIndex: Int?
    
    var isANewNote: Bool {
        return note.isEmpty
    }
    
    var title: String {
        note.title
    }
    
    var date: String {
        // If notes created/updated the same day, show time only
        // else show date
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.dateFormat = "MM/dd/yyyy"
        
        let dateFormatterForTime = DateFormatter()
        dateFormatterForTime.dateFormat = "hh:mm a"
        
        if note.date < Date() {
            return dateFormatterForDate.string(from: note.date)
        } else {
            return dateFormatterForTime.string(from: note.date)
        }
    }
    
    var content: String {
        note.content
    }
    
    var contentWithTitle: String {
        "\(title)\n\(content)"
    }
    
    // TODO: Get saved image if there's any
    var image: UIImage? {
        if let systemName = note.imageName { // Just for testing
            return UIImage(systemName: systemName)
        }
        return nil
    }
    
    // MARK: - Init
    init(note: Note, selectedIndex: Int? = nil) {
        self.note = note
        self.selectedIndex = selectedIndex
    }
    
    // MARK: -
    mutating func updateNote(with title: String, content: String) {
        note.update(title: title, content: content)
    }
}

extension NoteViewModel: NoteRepresentable { }

