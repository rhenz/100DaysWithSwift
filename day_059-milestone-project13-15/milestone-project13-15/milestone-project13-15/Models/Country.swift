//
//  Country.swift
//  milestone-project13-15
//
//  Created by John Salvador on 5/11/22.
//

import Foundation

struct Country: Codable {
    var name: String
    var code: String
    var capital: String
    var totalLandArea: Double
    var population: Int
    var currency: String
    
    enum TableSection: Int, CaseIterable {
        case name = 0
        case code
        case capital
        case totalLandArea
        case population
        case currency
        
        var sectionTitle: String {
            switch self {
            case .name:
                return "Name"
            case .code:
                return "Code"
            case .capital:
                return "Capital"
            case .totalLandArea:
                return "Total Land Area"
            case .population:
                return "Population"
            case .currency:
                return "Currency"
            }
        }
    }
}
