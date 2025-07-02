//
//  SwiftUIView.swift
//  FirstAidGuide
//
//  Created by itkhld on 2024-11-07.
//

import SwiftUI

struct UserGuideView: View {
    
    @State private var keyFetures = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // About App Card
                        VStack(spacing: 16) {
                            Image("logo")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                            
                            Text("First Aid Guide")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Your Personal Emergency Assistant")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("The **Basic First Aid Guide** app serves as a practical tool for users to learn essential first aid techniques and skills for common emergencies. It can be particularly useful for families, schools, outdoor enthusiasts, and anyone who needs to be prepared for unexpected situations.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        
                        // Key Features Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.title2)
                                    .foregroundColor(.yellow)
                                Text("Key Features")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            FeatureRow(icon: "cross.case.fill", color: .red, title: "First Aid Techniques", description: "Step-by-step guides for common emergencies")
                            FeatureRow(icon: "location.fill", color: .blue, title: "Nearby Services", description: "Find hospitals and pharmacies near you")
                            FeatureRow(icon: "person.crop.circle.badge.plus", color: .green, title: "Emergency Contacts", description: "Quick access to important contacts")
                            FeatureRow(icon: "bell.badge.fill", color: .orange, title: "Reminders", description: "Set reminders for medical tasks")
                            FeatureRow(icon: "checklist", color: .purple, title: "Emergency Kit", description: "Track your emergency supplies")
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        
                        // About Developer Card
                        VStack(alignment: .center, spacing: 16) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text("About Developer")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            
                            VStack(alignment: .center, spacing: 8) {
                                Text("itkhld")
                                    .font(.headline)
                                
                                Text("Version 1.0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("User Guide")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    UserGuideView()
}
