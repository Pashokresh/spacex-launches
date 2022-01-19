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
    
    @Published var sortingType: SortingType {
        didSet {
            launches = sortLaunches(launches)
            if oldValue != sortingType {
                userSettings.updateSortingParameter(sortingType: sortingType)
            }
        }
    }
    
    @Published var searchText: String = "" {
        didSet {
            filterLaunches()
        }
    }
    
    private var allLaunches = [LaunchModel]()
    
    private var bag: Set<AnyCancellable> = []
    private var dataManager: ServiceProtocol
    private var userSettings: UserSettings
    
    init(dataManager: ServiceProtocol = Service.shared, userSettings: UserSettings = UserSettings.shared) {
        self.dataManager = dataManager
        self.userSettings = userSettings
        self.sortingType = self.userSettings.getSortingParamter()
        
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
    
    private func createAlert(with error: NetworkError) {
        launchesLoadingError = error.backendError == nil ?
        error.initialError.localizedDescription
        : error.backendError!.message
    }
    
    private func filterLaunches() {
        launches = sortLaunches(searchText == "" ? allLaunches : allLaunches.filter({
            $0.name.contains(searchText)
            || $0.details?.contains(searchText) ?? false
            || $0.rocket?.contains(searchText) ?? false
        }))
    }
    
    private func sortLaunches(_ launches: [LaunchModel]) -> [LaunchModel] {
        return launches.sorted { first, second in
            switch self.sortingType {
            case .dateAsc:
                return first.date ?? Date() < second.date ?? Date()
            case .dateDesc:
                return first.date ?? Date.init(timeIntervalSince1970: 0)
                > second.date ?? Date.init(timeIntervalSince1970: 0)
            case .nameAsc:
                return first.name < second.name
            case .nameDesc:
                return first.name > second.name
            }
        }
    }
}
