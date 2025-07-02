//
//  VoiceAssistance.swift
//  FirstAidGuide
//
//  Created by itkhld on 23.12.2024.
//

import Foundation
import Speech

class VoiceAssistanceController: NSObject, SFSpeechRecognizerDelegate, ObservableObject {
    
    let tech: FirstAidTechnique
    
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    private var speechSynthesizer = AVSpeechSynthesizer()
    
    init(tech: FirstAidTechnique) {
        self.tech = tech  // Initialize the 'tech' property
        super.init()
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        speechRecognizer?.delegate = self
    }
    
    func requestSpeechRecognitionPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                print("Speech recognition authorized")
                
            case .denied:
                print("User denied access to speech recognition")
                
            case .restricted:
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                print("Speech recognition not yet authorized")
                
            @unknown default:
                fatalError()
            }
        }
    }
    
    func startListening() {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            print("Speech recognizer is not available")
            return
        }
        
        do {
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            let inputNode = audioEngine.inputNode
            recognitionRequest?.shouldReportPartialResults = true
            
            recognitionTask = recognizer.recognitionTask(with: recognitionRequest!, resultHandler: { result, error in
                guard let result = result else {
                    print("Recognition failed: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                let bestTranscription = result.bestTranscription.formattedString
                print("Recognized speech: \(bestTranscription)")
                
                if bestTranscription.lowercased().contains("help") {
                    self.speakInstruction("Please call emergency services.")
                }
            })
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
                self.recognitionRequest?.append(buffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
        } catch {
            print("Audio engine failed to start: \(error.localizedDescription)")
            
        }
    }
    
    func stopSpeaking() {
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
    
    // Speak out the instructions
    func readDescription(_ instruction: String) {
        let speechUtterance = AVSpeechUtterance(string: instruction)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
    }
    
    func speakInstruction(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.preUtteranceDelay = 0.3 // Slight pause before speaking
        utterance.postUtteranceDelay = 0.5 // Pause after each sentence
        speechSynthesizer.speak(utterance)
    }
}
