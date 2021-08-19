//
//  EmptyView.swift
//  Rawgames
//
//  Created by Fidriyanto R on 16/08/21.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("No data available")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}
