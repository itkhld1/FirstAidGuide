//
//  EmergencyInfoView.swift
//  FirstAidGuide
//
//  Created by itkhld on 22.12.2024.
//


import SwiftUI

struct EmergencyInfo: Identifiable, Codable {
    var id = UUID()
    var nameOFPatient: String
    var bloodType: String
    var allergies: String
    var medicalConditions: String
    var note: String
}

enum BloodType: String, Identifiable, CaseIterable {
    var id: Self { self }
    case aPositive = "A+"
    case aNegative = "A-"
    case bPositive = "B+"
    case bNegative = "B-"
    case abPositive = "AB+"
    case abNegative = "AB-"
    case oPositive = "O+ or ORh+"
    case oNegative = "O- or ORh-"
}

// Key to store emergency information in @AppStorage
let emergencyInfoKey = "emergencyInfo"


struct EmergencyInfoView: View {
    @AppStorage(emergencyInfoKey) private var emergencyInfoData: Data = Data()
    @State private var emergencyInfo = EmergencyInfo(nameOFPatient: "", bloodType: "", allergies: "", medicalConditions: "", note: "")
    @State private var isEditing = false
    
    @State private var bloodtype: BloodType = .aPositive

        
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Patient Information Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 12) {
                                Image(systemName: "person.text.rectangle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .frame(width: 24, height: 24)
                                
                                Text("Patient Information")
                                    .foregroundColor(Color("FontColor"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            
                            if isEditing {
                                TextField("Enter name of patient", text: $emergencyInfo.nameOFPatient)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 4)
                            } else {
                                InfoRow(title: "Name", value: emergencyInfo.nameOFPatient)
                                    .padding(.leading, 36) // Align with content
                            }
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal, 16)
                        
                        // Medical Information Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 12) {
                                Image(systemName: "heart.text.square.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                                    .frame(width: 24, height: 24)
                                
                                Text("Medical Information")
                                    .foregroundColor(Color("FontColor"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 16) {
                                if isEditing {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Blood Type")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        Picker("Blood Type", selection: $bloodtype) {
                                            ForEach(BloodType.allCases) { type in
                                                Text(type.rawValue).tag(type)
                                            }
                                        }
                                        .pickerStyle(.menu)
                                    }
                                } else {
                                    InfoRow(title: "Blood Type", value: bloodtype.rawValue)
                                }
                                
                                if isEditing {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Allergies")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        TextField("Enter allergies", text: $emergencyInfo.allergies)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                } else {
                                    InfoRow(title: "Allergies", value: emergencyInfo.allergies)
                                }
                                
                                if isEditing {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Medical Conditions")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        TextField("Enter medical conditions", text: $emergencyInfo.medicalConditions)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                } else {
                                    InfoRow(title: "Medical Conditions", value: emergencyInfo.medicalConditions)
                                }
                            }
                            .padding(.leading, 36) // Align with content
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal, 16)
                        
                        // Additional Notes Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 12) {
                                Image(systemName: "note.text")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                    .frame(width: 24, height: 24)
                                
                                Text("Additional Notes")
                                    .foregroundColor(Color("FontColor"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            
                            if isEditing {
                                TextEditor(text: $emergencyInfo.note)
                                    .frame(height: 100)
                                    .padding(8)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            } else {
                                Text(emergencyInfo.note.isEmpty ? "No additional notes" : emergencyInfo.note)
                                    .foregroundColor(emergencyInfo.note.isEmpty ? .secondary : .primary)
                            }
                           // .padding(.leading, 36) // Align with content
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("Emergency Info")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isEditing {
                            saveEmergencyInfo()
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Save" : "Edit")
                            .fontWeight(.medium)
                    }
                }
            }
            .onAppear(perform: loadEmergencyInfo)
        }
    }
    
    private func saveEmergencyInfo() {
        emergencyInfo.bloodType = bloodtype.rawValue
        if let encoded = try? JSONEncoder().encode(emergencyInfo) {
            emergencyInfoData = encoded
        }
    }
    
    private func loadEmergencyInfo() {
        if let decoded = try? JSONDecoder().decode(EmergencyInfo.self, from: emergencyInfoData) {
            emergencyInfo = decoded
            if let type = BloodType(rawValue: emergencyInfo.bloodType) {
                bloodtype = type
            }
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value.isEmpty ? "Not specified" : value)
                .font(.body)
        }
    }
}

#Preview {
    EmergencyInfoView()
}
