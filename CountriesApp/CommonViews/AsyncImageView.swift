//
//  AsyncImageView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI
import Kingfisher

struct AsyncImageView: View {
    let url: String?
    let placeholder: Image?
    let size: CGSize
    let cornerRadius: CGFloat = 4
    
    var body: some View {
        KFImage(URL(string: url ?? ""))
            .placeholder {
                placeholderImage
            }
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    
    private var placeholderImage: some View {
        Group {
            if let placeholder {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height)
                    .foregroundColor(.gray)
            } else {
                EmptyView()
            }
        }
    }
}

