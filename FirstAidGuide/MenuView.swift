//
//  MenuView.swift
//  FirstAidGuide
//
//  Created by itkhld on 24.12.2024.
//

import SwiftUI

struct MenuView: View {
    
    @State private var searchText = ""
    
    var body: some View {
            NavigationStack {
                ZStack {
                    Color("BackgroundColor")
                        .ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Services Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Services")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 12) {
                                    NavigationLink(destination: NearbyServicesView()) {
                                        MenuCard(
                                            icon: "location.fill",
                                            iconColor: .red,
                                            title: "Nearby Hospitals",
                                            subtitle: "Find medical facilities near you"
                                        )
                                    }
                                    
                                    NavigationLink(destination: PharmacyView()) {
                                        MenuCard(
                                            icon: "cross.case.fill",
                                            iconColor: .green,
                                            title: "Nearby Pharmacies",
                                            subtitle: "Locate pharmacies in your area"
                                        )
                                    }
                                }
                            }
                            
                            // Contacts Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Contacts")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                NavigationLink(destination: EmergencyContactsView()) {
                                    MenuCard(
                                        icon: "person.crop.circle.badge.plus",
                                        iconColor: .blue,
                                        title: "Emergency Contacts",
                                        subtitle: "Add emergency contacts"
                                    )
                                }
                            }
                            
                            // Other Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Other")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                VStack(spacing: 12) {
                                    NavigationLink(destination: EmergencyInfoView()) {
                                        MenuCard(
                                            icon: "heart.text.square.fill",
                                            iconColor: .red,
                                            title: "Emergency Info",
                                            subtitle: "Important medical information"
                                        )
                                    }
                                    
                                    NavigationLink(destination: WhenToSeekHelpView()) {
                                        MenuCard(
                                            icon: "staroflife.fill",
                                            iconColor: .blue,
                                            title: "When to Seek Help",
                                            subtitle: "Guidelines for emergency situations"
                                        )
                                    }
                                    
                                    NavigationLink(destination: ReminderView()) {
                                        MenuCard(
                                            icon: "alarm.fill",
                                            iconColor: .orange,
                                            title: "Set Reminder",
                                            subtitle: "Schedule important reminders"
                                        )
                                    }
                                    
                                    NavigationLink(destination: ChecklistView()) {
                                        MenuCard(
                                            icon: "checklist",
                                            iconColor: .green,
                                            title: "Emergency Kit Checklist",
                                            subtitle: "Keep track of essential items"
                                        )
                                    }
                                }
                            }
                            
                            // About Section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("About App")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                NavigationLink(destination: UserGuideView()) {
                                    MenuCard(
                                        icon: "info.circle.fill",
                                        iconColor: .indigo,
                                        title: "How to Use App",
                                        subtitle: "Learn features & functionality"
                                    )
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .navigationTitle("Menu")
                    .navigationBarTitleDisplayMode(.large)
                }
            }
    }
}

struct MenuCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(iconColor.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("FontColor"))
                
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color("FontColor"))
                .font(.system(.subheadline, weight: .semibold))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("Color"))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

#Preview {
    MenuView()
}
