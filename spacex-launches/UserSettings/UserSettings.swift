//
//  UserSettings.swift
//  SpaceXLaunches
//
//  Created by Pavel on 19.01.2022.
//

import Foundation


class UserSettings {
    static let shared = UserSettings()
    
    fileprivate let sortingKey = "SpaceX_Launches_Sorting_Key"
    
    func updateSortingParameter(sortingType: SortingType) {
        UserDefaults.standard.set(sortingType.rawValue, forKey: sortingKey)
    }
    
    func getSortingParamter() -> SortingType {
        guard let rawValue = UserDefaults.standard.value(forKey: sortingKey) as? String else {
            return SortingType.dateAsc
        }
        
        return SortingType.init(rawValue: rawValue) ?? SortingType.dateAsc
    }
}
