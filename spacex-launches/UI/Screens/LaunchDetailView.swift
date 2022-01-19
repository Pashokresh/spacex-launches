//
//  LaunchDetailView.swift
//  SpaceXLaunches
//
//  Created by Pavel on 18.01.2022.
//

import SwiftUI

struct LaunchDetailView: View {
    var launch: LaunchModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12, content: {
                VStack(alignment: .center, spacing: 8) {
                    Text(launch.name)
                        .font(.headline)
                    if let date = launch.date {
                        Text(date.mediumFormatString())
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }.padding()
                
                VStack(alignment: .leading, spacing: 3) {
                    if let rocket = launch.rocket {
                        LaunchDetailRow(title: "Rocket:", value: rocket)
                    }
                    
                    LaunchDetailRow(title: "Success:",
                                    value: launch.success != nil ? launch.success!.textValue() : "Unknown")
                    
                    if let fireDate = launch.fireDate {
                        LaunchDetailRow(title: "Fire Date:", value: fireDate.mediumFormatString())
                    }
                    
                    if let flightNumber = launch.flightNumber {
                        LaunchDetailRow(title: "Flight Number:", value: String(flightNumber))
                    }
                    
                    if let details = launch.details {
                        Text(details)
                            .padding()
                    }
                }
            })
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var launch = LaunchModel(fireDateStamp:
                                        Int64(Date.init().timeIntervalSince1970),
                                    rocket: "Appolon 1000",
                                    success: true,
                                    details: "We don't know anything", flightNumber: 12345,
                                    name: "Space-X Appolon 1000 Launch", dateStamp:
                                        Int64(Date.init().timeIntervalSince1970))
    
    static var previews: some View {
        LaunchDetailView(launch: launch)
    }
}
