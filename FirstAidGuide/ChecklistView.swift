//
//  ChecklistView.swift
//  FirstAidGuide
//
//  Created by itkhld on 25.12.2024.
//

import SwiftUI

struct ChecklistItem: Identifiable {
    let id = UUID()
    let title: String
    var isChecked: Bool
}

struct ChecklistView: View {
        
    @State private var checkListItems: [ChecklistItem] = [
        ChecklistItem(title: "First Aid Kit", isChecked: false),
        ChecklistItem(title: "Flashlight with Batteries", isChecked: false),
        ChecklistItem(title: "Water Bottles", isChecked: false),
        ChecklistItem(title: "Non-Perishable Food", isChecked: false),
        ChecklistItem(title: "Whistle (to signal for help)", isChecked: false),
        ChecklistItem(title: "Plastic sheeting, scissors and duct tape", isChecked: false),
        ChecklistItem(title: "Moist towelettes, garbage bags and plastic ties (for personal sanitation)", isChecked: false),
        ChecklistItem(title: "Manual can opener (for food)", isChecked: false),
        ChecklistItem(title: "Local maps", isChecked: false),
        ChecklistItem(title: "Cell phone with chargers and a backup battery", isChecked: false),
        ChecklistItem(title: "Soap, hand sanitizer and disinfecting wipes to disinfect surfaces", isChecked: false),
        ChecklistItem(title: "Non-prescription medications such as pain relievers, anti-diarrhea medication, antacids or laxatives", isChecked: false),
        ChecklistItem(title: "Prescription eyeglasses and contact lens solution", isChecked: false),

    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach($checkListItems) { $item in
                            HStack(spacing: 16) {
                                Button {
                                    withAnimation(.spring(response: 0.3)) {
                                        item.isChecked.toggle()
                                    }
                                } label: {
                                    Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isChecked ? .green : .gray)
                                        .font(.title2)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color(item.isChecked ? .green : .gray).opacity(0.1))
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.title)
                                        .font(.headline)
                                        .foregroundColor(item.isChecked ? .gray : .primary)
                                        .strikethrough(item.isChecked, color: .gray)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color("Color"))
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Emergency Kit")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ChecklistView()
}
