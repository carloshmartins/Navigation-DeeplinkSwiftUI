//
//  SettingsView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings Screen")
            NavigationLink(value: SettingsViewDestination.about) {
                Text("Go to About")
            }
            NavigationLink(value: SettingsViewDestination.preferences) {
                Text("Go to Preferences")
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
