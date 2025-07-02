//
//  ContentView.swift
//  FirstAidGuide
//
//  Created by itkhld on 22.12.2024.
//

import SwiftUI

struct FirstAidTechnique: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}

struct ContentView: View {
    
    @State private var favoriteTechniques = false
    @State private var isTechniqueFavorite = false
    @State private var searchText = ""
    @State private var chatBotShow: Bool = false
    
    var filteredTechniques: [FirstAidTechnique] {
        if searchText.isEmpty {
            return techniques
        } else {
            return techniques.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(spacing: 16) {
                    SearchBar(text: $searchText)
                    
                    List(filteredTechniques) { technique in
                        NavigationLink(destination: techniquesDetailView(technique: technique)) {
                            HStack {
                                Text(technique.title)
                                    .font(.system(.headline, design: .rounded))
                                    .foregroundColor(Color("FontColor"))
                                
                                Spacer()
                                
                                HStack(spacing: 12) {
                                    if isTechniqueCompleted(technique.id) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .imageScale(.large)
                                    }
                                    
                                    if isTechniqueFavorite(technique.id) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .imageScale(.large)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                                .padding(.vertical, 4)
                        )
                        .listRowSeparator(.hidden)
                        .cornerRadius(20)

                    }
                    .listStyle(PlainListStyle())
                    .padding(.horizontal)
                    .navigationTitle("First Aid Guide")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                withAnimation(.spring()) {
                                    chatBotShow.toggle()
                                }
                            }, label: {
                                Image(systemName: "ellipsis.message.fill")
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                            })
                            .sheet(isPresented: $chatBotShow, content: {
                                ChatBotView()
                                    .presentationDragIndicator(.visible)
                            })
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: FavoritesView(techniques: techniques)) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
//                                    Text("Favorites")
//                                        .fontWeight(.medium)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func isTechniqueCompleted(_ id: UUID) -> Bool {
        let completed = UserDefaults.standard.array(forKey: "completedTechniques") as? [String] ?? []
        return completed.contains(id.uuidString)
    }
    
    private func isTechniqueFavorite(_ id: UUID) -> Bool {
        let favorites = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [String] ?? []
        return favorites.contains(id.uuidString)
    }
}

#Preview {
    ContentView()
}
