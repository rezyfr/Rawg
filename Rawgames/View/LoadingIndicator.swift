//
//  LoadingIndicator.swift
//  Rawgames
//
//  Created by Fidriyanto R on 16/08/21.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var isLoading = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear {
                    self.isLoading = true
                }
        }
    }
}
