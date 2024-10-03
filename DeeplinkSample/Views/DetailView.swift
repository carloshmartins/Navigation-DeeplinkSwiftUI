//
//  DetailView.swift
//  DeeplinkSample
//
//  Created by Carlos on 03/10/24.
//

import SwiftUI

struct DetailView: View {
    let detailID: String

    var body: some View {
        Text("Detail Screen with ID: \(detailID)")
            .navigationTitle("Detail")
    }
}

//#Preview {
//    DetailView()
//}
