//
//  DeeplinkSampleApp.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

@main
struct DeeplinkApp: App {
    @StateObject private var router = AppNavigator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .onOpenURL { url in
                    router.handleDeeplink(url: url)
                }
        }
    }
}
