//
//  ContentView.swift
//  Rawgames
//
//  Created by Fidriyanto R on 09/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GameList().background(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
