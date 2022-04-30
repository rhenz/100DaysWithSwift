//
//  Storm.swift
//  Project1
//
//  Created by John Salvador on 4/30/22.
//

import Foundation

struct Storm: Codable, Comparable {
    
    static func < (lhs: Storm, rhs: Storm) -> Bool {
        return lhs.image < rhs.image
    }
    
    var image: String
    private(set) var viewCount: Int = 0
    
    mutating func addViewCount() {
        viewCount += 1
    }
}
