//
//  ChatBotAPI.swift
//  FirstAidGuide
//
//  Created by itkhld on 3.01.2025.
//

import Foundation

class ChatbotAPI {
    static let shared = ChatbotAPI()
    private let apiKey = "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"
    private let baseURL = "https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill"

    func getResponse(prompt: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            completion("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "inputs": prompt,
            "parameters": [
                "max_length": 100,
                "temperature": 0.7,
                "top_p": 0.9
            ]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error encoding request: \(error.localizedDescription)")
            completion("Error encoding request")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion("Network error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                completion("No data received")
                return
            }

            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let generatedText = jsonResponse.first?["generated_text"] as? String {
                    let cleanedResponse = generatedText.trimmingCharacters(in: .whitespacesAndNewlines)
                    print("Response received: \(cleanedResponse)")
                    completion(cleanedResponse)
                } else {
                    // Try parsing error response
                    if let errorResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let errorMessage = errorResponse["error"] as? String {
                        print("API Error: \(errorMessage)")
                        completion("API Error: \(errorMessage)")
                    } else {
                        print("Unexpected response format: \(String(data: data, encoding: .utf8) ?? "N/A")")
                        completion("Unexpected response format")
                    }
                }
            } catch {
                print("Error parsing response: \(error.localizedDescription)")
                completion("Error parsing response")
            }
        }

        task.resume()
    }
}
