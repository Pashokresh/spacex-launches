//
//  LaunchesResponse.swift.swift
//  spacex-launches
//
//  Created by Pavel on 16.12.2021.
//

import Foundation


struct LaunchesResponse: Decodable {
    let launches: [LaunchModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        launches = try container.decode([LaunchModel].self)
    }
}

struct LaunchModel: Decodable, Identifiable {
    let id = UUID()
    
    fileprivate let fireDateStamp: Int64?
    
    let rocket: String?
    
    let success: Bool?
    
    let details: String?
    
    let flightNumber: Int64?
    
    let name: String
    
    fileprivate let dateStamp: Int64?
    
    
    enum CodingKeys: String, CodingKey {
        case fireDateStamp = "static_fire_date_unix"
        case flightNumber = "flight_number"
        case dateStamp = "date_unix"
        
        case rocket
        case success
        case details
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fireDateStamp = try values.decode(Int64?.self, forKey: .fireDateStamp)
        rocket = try values.decode(String?.self, forKey: .rocket)
        success = try values.decode(Bool?.self, forKey: .success)
        details = try values.decode(String?.self, forKey: .details)
        flightNumber = try values.decode(Int64?.self, forKey: .flightNumber)
        name = try values.decode(String.self, forKey: .name)
        dateStamp = try values.decode(Int64?.self, forKey: .dateStamp)
        
    }
    
    init(fireDateStamp: Int64?,
         rocket: String?,
         success: Bool?,
         details: String?,
         flightNumber: Int64?,
         name: String,
         dateStamp: Int64?) {
        self.fireDateStamp = fireDateStamp
        self.rocket = rocket
        self.success = success
        self.details = details
        self.flightNumber = flightNumber
        self.name = name
        self.dateStamp = dateStamp
    }
}

extension LaunchModel {
    var fireDate: Date? {
        transform(interval: fireDateStamp)
    }
    
    var date: Date? {
        transform(interval: dateStamp)
    }
    
    private func transform(interval: Int64?) -> Date? {
        guard let interval = interval else { return nil }
        let timeInterval = TimeInterval(interval)
        return Date(timeIntervalSince1970: timeInterval)
    }
}
