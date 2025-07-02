//
//  EmergencyContactView.swift
//  FirstAidGuide
//
//  Created by itkhld on 22.12.2024.
//

import SwiftUI

struct EmergencyContact: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var phoneNumber: String
}

let emergencyContactsKey = "emergencyContacts"

struct EmergencyContactsView: View {
    @AppStorage(emergencyContactsKey) private var contactsData: Data = Data()
    @State private var contacts: [EmergencyContact] = []
    @State private var newContactName: String = ""
    @State private var newContactPhone: String = ""
    @State private var showAddContact = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(contacts) { contact in
                            HStack(spacing: 16) {
                                Image(systemName: "person.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .frame(width: 40, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.blue.opacity(0.1))
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(contact.name)
                                        .font(.headline)
                                        .foregroundColor(Color("FontColor"))

                                    Text(contact.phoneNumber)
                                        .font(.subheadline)
                                        .foregroundColor(Color("FontColor"))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    if let index = contacts.firstIndex(of: contact) {
                                        contacts.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .font(.system(.subheadline, weight: .medium))
                                }
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
                
                // Add Contact Button
                VStack {
                    Spacer()
                    Button(action: { showAddContact.toggle() }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Contact")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue)
                                .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 2)
                        )
                        .padding()
                    }
                }
            }
            .navigationTitle("Emergency Contacts")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showAddContact) {
                NavigationView {
                    Form {
                        Section {
                            TextField("Name", text: $newContactName)
                            TextField("Phone Number", text: $newContactPhone)
                                .keyboardType(.phonePad)
                        }
                    }
                    .navigationTitle("New Contact")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showAddContact = false
                        },
                        trailing: Button("Save") {
                            let contact = EmergencyContact(name: newContactName, phoneNumber: newContactPhone)
                            contacts.append(contact)
                            newContactName = ""
                            newContactPhone = ""
                            showAddContact = false
                        }
                        .disabled(newContactName.isEmpty || newContactPhone.isEmpty)
                    )
                }
                .presentationDetents([.height(250)])
            }
            .onAppear(perform: loadContacts)
            .onChange(of: contacts) { _ in saveContacts() }
        }
    }
    
    public func saveContacts() {
        if let encodedData = try? JSONEncoder().encode(contacts) {
            contactsData = encodedData
        }
    }
    
    public func loadContacts() {
        if let decodedData = try? JSONDecoder().decode([EmergencyContact].self, from: contactsData) {
            contacts = decodedData
        }
    }
}

#Preview {
    EmergencyContactsView()
}
