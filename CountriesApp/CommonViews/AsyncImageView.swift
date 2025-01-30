//
//  AsyncImageView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String?
    let placeholder: Image?
    let size: CGSize
    let cornerRadius: CGFloat = 4
    
    var body: some View {
        if let urlString = url, !urlString.isEmpty, let imageURL = URL(string: urlString) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.width, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                case .failure:
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }
    
    private var placeholderImage: some View {
        Group {
            if let placeholder {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.gray)
            } else {
                EmptyView()
            }
        }
    }
}

