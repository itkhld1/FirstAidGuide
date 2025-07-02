//
//  SwiftUIView.swift
//  FirstAidGuide
//
//  Created by itkhld on 2024-11-08.
//

import SwiftUI

struct Tabs: View {

    @State private var selectedTab = 1
    let hapticTouch = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                ContentView()
                    .tabItem {
                        Label("First Aids", systemImage: "cross.case.fill")
                    }
                    .tag(1)

                MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "line.3.horizontal")
                    }
                    .tag(2)
            }
            .onChange(of: selectedTab) { _ in
                hapticTouch.impactOccurred()
            }
        }
        .onAppear{
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color("BackgroundColor"))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    Tabs()
}
