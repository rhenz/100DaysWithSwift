//
//  Note.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation

struct Note {
    var title: String
    var date: Date
    var content: String
    var imageName: String?
    
    init() {
        self.title = ""
        self.date = Date()
        self.content = ""
        self.imageName = nil
    }
    
    init(title: String, date: Date, content: String, imageName: String? = nil) {
        self.title = title
        self.date = date
        self.content = content
        self.imageName = imageName
    }
}


// MARK: - Test Data
extension Note {
    static let testNote = Note(title: "Sample Title", date: Date(), content: "Lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem")
    
    static var testData: [Note] {
        
        var notes: [Note] = []
        for _ in 1...20 {
            notes.append(testNote)
        }
        
        notes.append(Note(title: "Sample Title", date: Date(), content: "Lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem", imageName: "flame.circle.fill"))
        
        return notes
    }
}
