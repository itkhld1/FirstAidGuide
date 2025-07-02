//
//  FavoritesView.swift
//  FirstAidGuide
//
//  Created by itkhld on 22.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    @State private var favoriteTechniqueIDs: [UUID] = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [UUID] ?? []
    let techniques: [FirstAidTechnique]
    
    var favoriteTechniques: [FirstAidTechnique] {
        techniques.filter { favoriteTechniqueIDs.contains($0.id) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    if favoriteTechniques.isEmpty {
                        Text("No favorite techniques yet.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(favoriteTechniques) { technique in
                            NavigationLink(destination: techniquesDetailView(technique: technique)) {
                                Text(technique.title)
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
                .navigationTitle("Favorite Techniques")
                .onAppear {
                    loadFavorites()
                }
            }
        }
    }
    
    private func loadFavorites() {
        if let savedIDs = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [String] {
            favoriteTechniqueIDs = savedIDs.compactMap { UUID(uuidString: $0) }
        }
    }
}
#Preview {
    FavoritesView(techniques: .init([.init(title: "First Aid", description: "", imageName: ""), .init(title: "First Aid", description: "", imageName: "")]))
}
