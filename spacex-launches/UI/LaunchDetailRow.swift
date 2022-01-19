//
//  LaunchDetailsRow.swift
//  SpaceXLaunches
//
//  Created by Pavel on 19.01.2022.
//

import SwiftUI

struct LaunchDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text(title)
                    .font(.headline)
            Spacer()
            Text(value)
        }
        .padding([.leading, .trailing], 16)
    }
}

struct LaunchDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailRow(title: "Details:",
                         value: """
The Landmark data already has the id property required by Identifiable protocol;
you only need to add a property to decode it when reading the data
""")
    }
}
