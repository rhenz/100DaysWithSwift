//
//  Note.swift
//  milestone-project19-21
//
//  Created by John Salvador on 5/24/22.
//

import Foundation

struct Note: Codable {
    var title: String
    var date: Date
    var content: String
    var imageName: String?
    
    var isEmpty: Bool {
        return title.isEmpty && content.isEmpty
    }
    
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
    
    // MARK: -
    mutating func update(title: String, content: String) {
        self.title = title
        self.content = content
    }
}


// MARK: - Test Data
extension Note {
    static let testNote = Note(title: "Sample Title", date: Date(), content: "Lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem")
    
    static var testData: [Note] {
        
        var notes: [Note] = []
        for _ in 1...5 {
            notes.append(testNote)
        }
        
        notes.append(Note(title: "Sample Title", date: Date(), content: "Lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem ipsum ipsum lorem", imageName: "flame.circle.fill"))
        
        return notes
    }
}
