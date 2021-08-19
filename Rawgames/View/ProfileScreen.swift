//
//  ProfileScreen.swift
//  Rawgames
//
//  Created by Fidriyanto R on 16/08/21.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                RoundedImage(image: "displaypic", size: 200).padding()
                Text("Fidriyanto Rizkillah").font(.headline).foregroundColor(.white).padding(.horizontal, 32.0)
                Text("frizkillah98@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32.0)
                Spacer()
            }
        }.navigationBarHidden(false)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
