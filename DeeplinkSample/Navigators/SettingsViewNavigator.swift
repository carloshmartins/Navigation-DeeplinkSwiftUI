//
//  SettingsView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct SettingsViewNavigator: View {
    @EnvironmentObject
    var router: AppNavigator
    
    var body: some View {
        NavigationStack(path: $router.settingsPath) {
            SettingsView()
                .navigationDestination(for: SettingsViewDestination.self) { destination in
                    switch destination {
                    case .about:
                        AboutView()
                    case .preferences:
                        PreferencesView()
                    }
                }
        }
        .tabItem {
            Label("Settings", systemImage: "gearshape")
        }
        .tag(Tab.settings)
    }
}

#Preview {
    SettingsView()
}
