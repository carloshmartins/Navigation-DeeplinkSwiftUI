//
//  ContentView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: AppNavigator

    var body: some View {
        TabView(selection: $router.currentTab) {
            
            HomeViewNavigator()
                .environmentObject(router)
            
            ProfileViewNavigator()
                .environmentObject(router)
    
            SettingsViewNavigator()
                .environmentObject(router)
        }
        .sheet(isPresented: $router.showModal) {
            if let modalType = router.modalType {
                ModalView(modalType: modalType)
            }
        }
        .fullScreenCover(isPresented: $router.showFullScreen) {
            if let fullScreenType = router.fullScreenType {
                FullScreenCoverView(fullScreenType: fullScreenType)
            }
        }
    }
}

struct ModalView: View {
    let modalType: ModalType

    var body: some View {
        switch modalType {
        case .editProfile:
            EditProfile()
        case .about:
            AboutView()
        }
    }
}

struct FullScreenCoverView: View {
    @Environment(\.isPresented) var isPresented
    
    let fullScreenType: FullScreenCoverType

    var body: some View {
        switch fullScreenType {
        case .preferences:
            PreferencesView()
        case .editProfileFullScreen:
            EditProfile()
        }
    }
}
