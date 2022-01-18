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
                    Text(launch.name)
                }
            }.navigationTitle("Space-X Launches")
        }.searchable(text: $launchesViewModel.searchText)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchesListView()
//    }
//}
