//
//  SearchView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    
    var body: some View {
        EmptyView()
            .searchable(text: $query, placement: .automatic)
    }
}

#Preview {
    SearchView()
}
