//
//  ProfileView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile Screen")
            NavigationLink(value: ProfileViewDestination.detail("456")) {
                Text("Go to Profile Detail")
            }
            NavigationLink(value: ProfileViewDestination.editProfile) {
                Text("Edit Profile")
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
