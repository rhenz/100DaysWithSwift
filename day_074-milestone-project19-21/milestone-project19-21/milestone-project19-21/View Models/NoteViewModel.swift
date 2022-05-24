//
//  NoteViewModel.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation
import UIKit

struct NoteViewModel {
    
    // MARK: - Properties
    let note: Note
    
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
    
    // Just get a portion of content?
//    var contentPreview: String {
//        note.content.range
//    }
    
    // TODO: Get saved image if there's any
    var image: UIImage? {
        if let systemName = note.imageName { // Just for testing
            return UIImage(systemName: systemName)
        }
        return nil
    }
}

extension NoteViewModel: NoteRepresentable { }

