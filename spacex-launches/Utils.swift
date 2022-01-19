//
//  Utils.swift
//  SpaceXLaunches
//
//  Created by Pavel on 19.01.2022.
//

import Foundation

extension Date {
    func mediumFormatString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .medium)
    }
}

extension Bool {
    func textValue() -> String {
        return self ? "Yes" : "No"
    }
}
