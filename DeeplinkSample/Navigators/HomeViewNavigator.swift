//
//  HomeViewNavigator.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct HomeViewNavigator: View {
    @EnvironmentObject var router: AppNavigator
    
    var body: some View {
        NavigationStack(path: $router.homePath) {
            HomeView()
                .navigationDestination(for: HomeViewDestination.self) { destination in
                    switch destination {
                    case .extraInfo:
                        ExtraInfoView()
                    case let .detail(detailModel):
                        DetailView(detailID: detailModel)
                    }
                }
        }
        .tabItem {
            Label("Home", systemImage: "house")
        }
        .tag(Tab.home)
    }
}

//#Preview {
//    HomeView()
//}
