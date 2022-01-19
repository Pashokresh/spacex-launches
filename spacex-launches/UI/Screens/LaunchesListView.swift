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
            }.navigationTitle("Space-X Launches")
                .navigationBarTitleDisplayMode(.large)
        }.searchable(text: $launchesViewModel.searchText)
        .alert(isPresented: $launchesViewModel.showAlert) {
                Alert(title: Text("Error"),
                      message: Text(launchesViewModel.launchesLoadingError),
                      dismissButton: .default(Text("OK")))
        }.navigationViewStyle(.stack)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchesListView()
//    }
//}
