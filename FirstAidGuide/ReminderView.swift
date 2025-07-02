//
//  ReminderView.swift
//  FirstAidGuide
//
//  Created by itkhld on 25.12.2024.
//

import SwiftUI
import UserNotifications

struct ReminderView: View {
    @State private var reminderTitle = ""
    @State private var reminderDate = Date()
    @State private var scheduledReminders: [NotificationItem] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // New Reminder Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "bell.badge.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text("Set New Reminder")
                                    .foregroundColor(Color("FontColor"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom, 4)
                            
                            VStack(spacing: 12) {
                                TextField("Title", text: $reminderTitle)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal, 4)
                                
                                DatePicker("Date & Time", selection: $reminderDate, displayedComponents: [.date, .hourAndMinute])
                                    .padding(.horizontal, 4)
                                
                                Button(action: {
                                    addReminder()
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Set Reminder")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.blue)
                                            .shadow(color: Color.blue.opacity(0.3), radius: 3, x: 0, y: 2)
                                    )
                                }
                                .disabled(reminderTitle.isEmpty)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("Color"))
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        )
                        .padding(.horizontal)
                        
                        // Scheduled Reminders Card
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "list.bullet.clipboard.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                                Text("Scheduled Reminders")
                                    .foregroundColor(Color("FontColor"))
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding(.bottom, 4)
                            
                            if scheduledReminders.isEmpty {
                                HStack {
                                    Spacer()
                                    VStack(spacing: 8) {
                                        Image(systemName: "bell.slash")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                        Text("No reminders scheduled")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding()
                            } else {
                                ForEach(scheduledReminders) { reminder in
                                    HStack(spacing: 16) {
                                        Image(systemName: "bell.fill")
                                            .font(.title2)
                                            .foregroundColor(.orange)
                                            .frame(width: 40, height: 40)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.orange.opacity(0.1))
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(reminder.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            HStack {
                                                Image(systemName: "calendar")
                                                    .foregroundColor(.gray)
                                                Text(reminder.date, style: .date)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                
                                                Image(systemName: "clock")
                                                    .foregroundColor(.gray)
                                                Text(reminder.date, style: .time)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                                    )
                                }
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
                    .padding(.vertical)
                }
            }
            .navigationTitle("Reminders")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                NotificationManager.shared.requestPermission()
                fetchScheduledNotifications()
            }
        }
    }
    
    private func addReminder() {
        print("Scheduling reminder for \(reminderTitle) at \(reminderDate)")
        NotificationManager.shared.scheduleNotification(
            title: reminderTitle,
            body: "Don't forget to \(reminderTitle.lowercased())!",
            date: reminderDate
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            fetchScheduledNotifications() // Allow the system some time to register the new notification
        }
        reminderTitle = ""
        fetchScheduledNotifications() // Refresh the list
    }
    
    private func fetchScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                self.scheduledReminders = requests.compactMap { request in
                    guard let trigger = request.trigger as? UNCalendarNotificationTrigger,
                          let nextTriggerDate = trigger.nextTriggerDate() else {
                        return nil
                    }
                    return NotificationItem(id: request.identifier, title: request.content.title, date: nextTriggerDate)
                }
                print("Fetched \(self.scheduledReminders.count) scheduled reminders")
            }
        }
    }

    
//    private func fetchScheduledNotifications() {
//        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
//            DispatchQueue.main.async {
//                scheduledReminders = requests.map { request in
//                    let title = request.content.title
//                    let trigger = request.trigger as? UNCalendarNotificationTrigger
//                    let date = trigger?.nextTriggerDate() ?? Date()
//                    return NotificationItem(id: request.identifier, title: title, date: date)
//                }
//            }
//        }
//    }
}

// Data model for displaying scheduled reminders
struct NotificationItem: Identifiable {
    let id: String
    let title: String
    let date: Date
}



#Preview {
    ReminderView()
}
