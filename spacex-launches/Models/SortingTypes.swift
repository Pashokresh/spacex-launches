//
//  SortingTypes.swift
//  SpaceXLaunches
//
//  Created by Pavel on 19.01.2022.
//

import Foundation

enum SortingType: String, RawRepresentable, CaseIterable {
    case dateAsc
    case dateDesc
    case nameAsc
    case nameDesc
    
}

extension SortingType: Identifiable {
    
    var id: String { self.rawValue }
    
    func label() -> String {
        switch self {
        case .dateAsc:
            return "Date Ascending"
        case .dateDesc:
            return "Date Descending"
        case .nameAsc:
            return "Name Ascending"
        case .nameDesc:
            return "Name Descending"
        }
    }
}
