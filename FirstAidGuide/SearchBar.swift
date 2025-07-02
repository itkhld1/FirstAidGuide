//
//  SearchBar.swift
//  FirstAidGuide
//
//  Created by itkhld on 2024-11-10.
//

import SwiftUI

// Search Bar View
struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search...", text: $text)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(25)
        .padding(.horizontal)
    }
}
