//
//  HomeView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home Screen")
            NavigationLink(value: HomeViewDestination.detail("123")) {
                Text("Go to Home Detail")
            }
            NavigationLink(value: HomeViewDestination.extraInfo) {
                Text("Go to Extra Info")
            }
        }
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}
