//
//  LaunchesViewModel.swift
//  spacex-launches
//
//  Created by Pavel on 16.12.2021.
//

import Foundation
import Combine

class LaunchesViewModel: ObservableObject {
    
    @Published var launches: [LaunchModel] = [LaunchModel]()
    @Published var launchesLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    @Published var searchText: String = "" {
        didSet {
            filterLaunches()
        }
    }
    
    private var allLaunches = [LaunchModel]()
    
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
                    self?.showAlert = true
                    self?.createAlert(with: error)
                } else {
                    guard let launchesResponse = response.value else { return }
                    
                    self?.allLaunches = launchesResponse.launches
                    
                    self?.filterLaunches()
                }
            }
            .store(in: &bag)
    }
    
    func createAlert(with error: NetworkError) {
        launchesLoadingError = error.backendError == nil ?
        error.initialError.localizedDescription
        : error.backendError!.message
    }
    
    private func filterLaunches() {
        launches = searchText == "" ? allLaunches : allLaunches.filter({
                $0.name.contains(searchText)
            || $0.details?.contains(searchText) ?? false
            || $0.rocket?.contains(searchText) ?? false
        })
    }
}
