//
//  ProfileView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct ProfileViewNavigator: View {
    @EnvironmentObject
    var router: AppNavigator
    
    var body: some View {
        NavigationStack(path: $router.profilePath) {
            ProfileView()
                .navigationDestination(for: ProfileViewDestination.self) { destination in
                    switch destination {
                    case let .detail(detailModel):
                        DetailView(detailID: detailModel)
                    case .editProfile:
                        EditProfile()
                    }
                }
        }
        .tabItem {
            Label("Profile", systemImage: "person.circle")
        }
        .tag(Tab.profile)
    }
}

#Preview {
    ProfileView()
}
