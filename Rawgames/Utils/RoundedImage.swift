//
//  RoundedImage.swift
//  Rawgames
//
//  Created by Fidriyanto R on 16/08/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoundedImage: View {
    let image: String
    let size: CGFloat

    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            if image.hasPrefix("http") {
                WebImage(url: URL(string: image), options: .highPriority, context: nil)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
            } else {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(size/2)
            }
        }
    }
}
