//
//  Person.swift
//  Project10
//
//  Created by John Salvador on 4/26/22.
//

import Foundation

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
