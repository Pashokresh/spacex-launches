//
//  Errors.swift
//  spacex-launches
//
//  Created by Pavel on 16.12.2021.
//

import Foundation
import Alamofire

struct NetworkError: Error {
    let initialError: AFError
    let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
