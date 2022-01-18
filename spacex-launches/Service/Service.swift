//
//  Service.swift
//  spacex-launches
//
//  Created by Pavel on 16.12.2021.
//

import Foundation
import Alamofire
import Combine

protocol ServiceProtocol {
    func fetchLaunches() -> AnyPublisher<DataResponse<LaunchesResponse, NetworkError>, Never>
}

class Service {
    static let shared: ServiceProtocol = Service()
    
    fileprivate let baseURL = "https://api.spacexdata.com/"
    fileprivate let version = "v4/"
    
    private init() { }
}

extension Service: ServiceProtocol {
    
    func fetchLaunches() -> AnyPublisher<DataResponse<LaunchesResponse, NetworkError>, Never> {
        let endPoint = "launches"
        let url = URL(string: baseURL + version + endPoint)!
        
        return AF.request(url,
                   method: .get)
            .validate()
            .publishDecodable(type: LaunchesResponse.self)
            .map { response in
                response.mapError { error -> NetworkError in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0) }
                    return NetworkError(initialError: error, backendError: backendError)
                    
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
