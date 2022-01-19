//
//  ContentView.swift
//  spacex-launches
//
//  Created by Pavel on 02.12.2021.
//

import SwiftUI
import Combine

struct LaunchesListView: View {
    @ObservedObject var launchesViewModel = LaunchesViewModel()
    @State private var isShowingSortingOptions = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(launchesViewModel.launches, id: \.id) { launch in
                    NavigationLink(
                        destination: LaunchDetailView(launch: launch),
                        label: {
                            Text(launch.name)
                        }
                    )}
            }
            .refreshable {
                launchesViewModel.fetchLaunches()
            }
            .navigationTitle("Space-X Launches")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    Button("Sort") {
                        isShowingSortingOptions = true
                    }
                }
        }
        .confirmationDialog("Pick sorting option", isPresented: $isShowingSortingOptions, actions: {
            ForEach(SortingType.allCases, id: \.id) { sortingType in
                Button(sortingType.label()) {
                    launchesViewModel.sortingType = sortingType
                }
            }
        })
        .searchable(text: $launchesViewModel.searchText)
            .alert(isPresented: $launchesViewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text(launchesViewModel.launchesLoadingError),
                      dismissButton: .default(Text("OK")))
            }.navigationViewStyle(.stack)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesListView()
    }
}
