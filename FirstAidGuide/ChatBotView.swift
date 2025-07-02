//
//  ChatBotView.swift
//  FirstAidGuide
//
//  Created by itkhld on 26.12.2024.
//


import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct ChatBotView: View {
    @State private var messages: [Message] = []
    @State private var messageText: String = ""
    @State private var isTyping: Bool = false
    @State private var typingIndicatorID = UUID()
    @Environment(\.colorScheme) var colorScheme
    
    private let chatbotAPI = ChatbotAPI.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack(spacing: 0) {
                    // Chat messages
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(messages) { message in
                                    MessageBubble(message: message)
                                        .transition(.asymmetric(
                                            insertion: .scale.combined(with: .opacity),
                                            removal: .opacity
                                        ))
                                }
                                if isTyping {
                                    TypingIndicator()
                                        .id(typingIndicatorID)
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
                        }
                        .onChange(of: messages.count) { _ in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                if isTyping {
                                    proxy.scrollTo(typingIndicatorID, anchor: .bottom)
                                } else if let lastMessage = messages.last {
                                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: isTyping) { _ in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                if isTyping {
                                    proxy.scrollTo(typingIndicatorID, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    // Input area
                    VStack(spacing: 0) {
                        Divider()
                            .background(Color.gray.opacity(0.3))
                        HStack(spacing: 12) {
                            TextField("Type your message...", text: $messageText)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.systemBackground))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                            
                            Button(action: sendMessage) {
                                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(messageText.isEmpty ? .gray : .blue)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 3, x: 0, y: 2)
                                    .scaleEffect(messageText.isEmpty ? 0.5 : 0.9)
                                    .animation(.spring(response: 0.3, dampingFraction: 2.0), value: messageText.isEmpty)
                            }
                            .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color("BackgroundColor"))
                    }
                }
                .navigationTitle("AI Assistant")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Image(systemName: "brain.head.profile")
                                .foregroundColor(.blue)
                            Text("AI Assistant")
                                .font(.headline)
                        }
                    }
                }
                .onAppear {
                    addWelcomeMessage()
                }
            }
        }
    }
    
    private func addWelcomeMessage() {
        let welcomeMessage = Message(
            content: "Hello! I'm your First Aid Guide assistant. How can I help you today?",
            isUser: false,
            timestamp: Date()
        )
        messages.append(welcomeMessage)
    }
    
    private func sendMessage() {
        let trimmedMessage = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }
        
        let userMessage = Message(content: trimmedMessage, isUser: true, timestamp: Date())
        messages.append(userMessage)
        messageText = ""
        
        isTyping = true
        
        chatbotAPI.getResponse(prompt: trimmedMessage) { response in
            DispatchQueue.main.async {
                isTyping = false
                if let response = response {
                    let botMessage = Message(content: response, isUser: false, timestamp: Date())
                    messages.append(botMessage)
                }
            }
        }
    }
}

struct MessageBubble: View {
    let message: Message
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                HStack(alignment: .top, spacing: 8) {
                    if !message.isUser {
                        Image(systemName: "brain.head.profile")
                            .foregroundColor(.blue)
                            .font(.system(size: 16))
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.1))
                            )
                    }
                    
                    Text(message.content)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(
                            Group {
                                if message.isUser {
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                } else {
                                    colorScheme == .dark ? Color(white: 0.3) : Color(white: 0.95)
                                }
                            }
                        )
                        .foregroundColor(message.isUser ? .white : .primary)
                        .cornerRadius(20)
                        .cornerRadius(message.isUser ? 20 : 20,
                                    corners: message.isUser ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight])
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                    
                    if message.isUser {
                        Image(systemName: "person.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 16))
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.1))
                            )
                    }
                }
                
                Text(formatTimestamp(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
                    .padding(.vertical, -15)
            }
            
            if !message.isUser { Spacer() }
        }
    }
    
    private func formatTimestamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .foregroundColor(.blue)
                .font(.system(size: 16))
                .padding(8)
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                )
            
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.blue.opacity(0.5))
                        .frame(width: 8, height: 8)
                        .offset(y: animationOffset)
                        .animation(
                            Animation.easeInOut(duration: 0.5)
                                .repeatForever()
                                .delay(0.2 * Double(index)),
                            value: animationOffset
                        )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
            
            Spacer()
        }
        .padding(.leading)
        .onAppear {
            animationOffset = -5
        }
    }
}

// Extension for rounded corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBotView()
}

