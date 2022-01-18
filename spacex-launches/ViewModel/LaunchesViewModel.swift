//
//  LaunchesViewModel.swift
//  spacex-launches
//
//  Created by Pavel on 16.12.2021.
//

import Foundation
import Combine

class LaunchesViewModel: ObservableObject {
    
    @Published var launches = [LaunchModel]()
    @Published var launchesLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    private var bag: Set<AnyCancellable> = []
    var dataManager: ServiceProtocol
    
    init(dataManager: ServiceProtocol = Service.shared) {
        self.dataManager = dataManager
        fetchLaunches()
    }
    
    func fetchLaunches() {
        dataManager.fetchLaunches()
            .sink { [weak self] response in
                if let error = response.error {
                    self?.createAlert(with: error)
                } else {
                    guard let launchesResponse = response.value else { return }
                    
                    self?.launches = launchesResponse.launches
                }
            }
            .store(in: &bag)
    }
    
    func createAlert(with error: NetworkError) {
        launchesLoadingError = error.backendError == nil ?
        error.initialError.localizedDescription
        : error.backendError!.message
    }
}
