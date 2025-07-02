//
//  SwiftUIView.swift
//  FirstAidGuide
//
//  Created by itkhld on 2024-11-10.
//

import SwiftUI

struct techniquesDetailView: View {
    
    //@State private var isTechniqueFavorite = false


    @ObservedObject var VoiceAssistance = VoiceAssistanceController(tech: FirstAidTechnique(title: "", description: "", imageName: ""))
    
    let technique: FirstAidTechnique
    @State private var stepsChecked: [Bool]
    
    
    
    init(technique: FirstAidTechnique) {
        self.technique = technique
        _stepsChecked = State(initialValue: Array(repeating: false, count: 10))
    }
    
    var body: some View {
            
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(technique.title)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.horizontal, 2.5)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 25)
//                                        .fill(Color("Color"))
//                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                        .frame(height: 50)
//                                        .padding(.horizontal, -0.5)
//                                )
                            
                            Spacer()
                            
                            Button(action: {
                                toggleFavorite()
                            }) {
                                Image(systemName: isTechniqueFavorite() ? "star.fill" : "star")
                                    .font(.title2)
                                    .foregroundColor(isTechniqueFavorite() ? .yellow : .gray)
                                    .frame(width: 44, height: 44)
                                    .background(
                                        Circle()
                                            .fill(Color("Color"))
                                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                    )
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Image(technique.imageName)
                            .resizable()
                            //.scaledToFit()
                            
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal, 19)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Description")
                                .foregroundColor(Color("FontColor"))
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                VoiceAssistance.readDescription(technique.description)
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "speaker.wave.2.fill")
                                    Text("Voice Guide")
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.blue.opacity(0.1))
                                )
                            }
                        }
                        
                        Text(technique.description)
                            .font(.body)
                            .foregroundColor(Color("FontColor"))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("Color"))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Progress")
                            .foregroundColor(Color("FontColor"))
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        ProgressView(value: Double(stepsChecked.filter { $0 }.count), total: Double(stepsChecked.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .background(Color(.blue.opacity(0.1)))
                            .cornerRadius(8)
                        
                        Text("\(stepsChecked.filter { $0 }.count) of \(stepsChecked.count) steps completed")
                            .font(.caption)
                            .foregroundColor(Color("FontColor"))
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("Color"))
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal, 16)
                    
                    // Steps Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Steps to Follow")
                                .foregroundColor(Color("FontColor"))
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Button(action: {
                                let steps = (0..<stepsChecked.count).map { getStepDescription(for: $0) }
                                let combinedSteps = steps.joined(separator: ". Next, ")
                                VoiceAssistance.speakInstruction(combinedSteps)
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "play.circle.fill")
                                    Text("Read Steps")
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.blue.opacity(0.1))
                                )
                            }
                        }
                        
                        VStack(spacing: 16) {
                            ForEach(0..<stepsChecked.count, id: \.self) { index in
                                HStack(alignment: .center, spacing: 16) {
                                    Button(action: {
                                        stepsChecked[index].toggle()
                                    }) {
                                        Image(systemName: stepsChecked[index] ? "checkmark.circle.fill" : "circle")
                                            .font(.title3)
                                            .foregroundColor(stepsChecked[index] ? .green : .gray)
                                            .frame(width: 24, height: 24)
                                            .background(
                                                Circle()
                                                    .fill(stepsChecked[index] ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
                                            )
                                    }
                                    .frame(width: 44, height: 44)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Step \(index + 1)")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.secondary)
                                        
                                        Text(getStepDescription(for: index))
                                            .font(.body)
                                            .foregroundColor(.primary)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .lineSpacing(4)
                                    }
                                    .padding(.vertical, 8)
                                    
                                    Spacer()
                                }
                                .padding(12)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color("Color"))
                                        .shadow(color: Color.black.opacity(0.03), radius: 3, x: 0, y: 1)
                                )
                            }
                        }
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
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            markAsCompleted()
        }
        .onDisappear {
            VoiceAssistance.stopSpeaking()
        }
    }
    
    private func markAsCompleted() {
        var completed = UserDefaults.standard.array(forKey: "completedTechniques") as? [String] ?? []
        if !completed.contains(technique.id.uuidString) {
            completed.append(technique.id.uuidString)
            UserDefaults.standard.set(completed, forKey: "completedTechniques")
        }
    }
    
    private func toggleFavorite() {
        var favorites = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [String] ?? []
        if let index = favorites.firstIndex(of: technique.id.uuidString) {
            favorites.remove(at: index)
        } else {
            favorites.append(technique.id.uuidString)
        }
        UserDefaults.standard.set(favorites, forKey: "favoriteTechniques")
    }
    
    private func isTechniqueFavorite() -> Bool {
        let favorites = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [String] ?? []
        return favorites.contains(technique.id.uuidString)
    }
    
    func addFavorite(id: UUID) {
        var favorites = UserDefaults.standard.array(forKey: "favoriteTechniques") as? [String] ?? []
        favorites.append(id.uuidString)
        UserDefaults.standard.set(favorites, forKey: "favoriteTechniques")
    }
    
    func getStepDescription(for index: Int) -> String {
        switch technique.title {
        case "CPR":
            switch index {
            case 0: return "Check responsiveness and call for help."
            case 1: return "Start chest compressions at a rate of 100-120 per minute."
            case 2: return "Open the airway and give rescue breaths."
            case 3: return "Continue CPR cycles of 30 compressions and 2 breaths."
            case 4: return "Monitor the person for signs of life, such as coughing, breathing, or movement."
            case 5: return "If the person regains consciousness, place them in the recovery position."
            case 6: return "Continue CPR until help arrives or the person shows signs of life."
            case 7: return "Use an AED if available and follow the device instructions."
            case 8: return "If trained, perform advanced life support techniques."
            case 9: return "Do not stop CPR until professional medical help arrives and takes over."
            case 10: return "Be prepared to assist medical professionals with patient care."
            default: return ""
            }
            
        case "Heimlich Maneuver":
            switch index {
            case 0: return "Stand behind the person and place your arms around their waist."
            case 1: return "Make a fist and place the thumb side above the person's navel."
            case 2: return "Grasp your fist with the other hand and perform a quick inward and upward thrust."
            case 3: return "Repeat thrusts until the object is expelled or the person can breathe."
            case 4: return "If the person is unconscious, carefully lower them to the ground."
            case 5: return "Perform chest compressions as in CPR."
            case 6: return "Look in the mouth for the object and remove it if visible."
            case 7: return "Continue CPR until medical help arrives."
            case 8: return "If you are alone and choking, perform abdominal thrusts on yourself using a firm surface."
            case 9: return "Seek medical attention immediately after the object is expelled."
            case 10: return "Learn and practice the Heimlich Maneuver to be prepared for emergencies."
            default: return ""
            }
            
        case "Treating Burns":
            switch index {
            case 0: return "Cool the burn with running water for at least 10 minutes."
            case 1: return "Remove the person from the heat source and remove any tight clothing around the burn."
            case 2: return "Cover the burn with a clean, non-stick bandage or cloth."
            case 3: return "Do not apply ice directly to the burn."
            case 4: return "Do not break blisters."
            case 5: return "Do not apply ointments or creams to the burn unless directed by a medical professional."
            case 6: return "Elevate the burned area above the heart if possible."
            case 7: return "Watch for signs of infection, such as redness, swelling, or pus."
            case 8: return "Seek medical attention for severe burns, such as those that are deep, large, or on the face, hands, feet, or genitals."
            case 9: return "Take over-the-counter pain relievers as needed."
            case 10: return "Protect the burn from further injury and sun exposure."
            default: return ""
            }
            
        case "Applying Bandages":
            switch index {
            case 0: return "Clean the wound with water and antiseptic if available."
            case 1: return "Place a sterile bandage or gauze over the wound."
            case 2: return "Secure the bandage with adhesive or medical tape."
            case 3: return "Ensure the bandage is tight enough to control bleeding but not too tight to cut off circulation."
            case 4: return "Check for circulation below the bandage by checking for warmth and color."
            case 5: return "Change the bandage regularly, especially if it becomes wet or dirty."
            case 6: return "If the wound is bleeding heavily, apply direct pressure first and then bandage."
            case 7: return "For puncture wounds, do not remove any object embedded in the skin."
            case 8: return "Watch for signs of infection, such as redness, swelling, or pus."
            case 9: return "Seek medical attention for deep wounds, puncture wounds, or wounds that show signs of infection."
            case 10: return "Proper bandaging can help prevent infection and promote healing."
            default: return ""
            }
            
        case "Control Bleeding":
            switch index {
            case 0: return "Apply direct pressure on the wound using a clean cloth or bandage."
            case 1: return "Elevate the injured area above the heart if possible."
            case 2: return "If bleeding continues, apply more pressure and consider a tourniquet as a last resort."
            case 3: return "Seek medical help if the bleeding doesn't stop."
            case 4: return "Do not remove any object embedded in the wound."
            case 5: return "If a tourniquet is used, write down the time it was applied."
            case 6: return "Monitor the person for signs of shock."
            case 7: return "Keep the injured person calm and reassured."
            case 8: return "If the bleeding is severe and life-threatening, focus on applying direct pressure and controlling the bleeding immediately."
            case 9: return "Learn basic first aid techniques, including how to control bleeding, to be prepared for emergencies."
            case 10: return "If you are unsure of how to proceed, seek guidance from emergency medical services or a trained medical professional."
            default: return ""
            }
            
        case "Treating Shock":
            switch index {
            case 0: return "Lay the person down and keep their legs elevated."
            case 1: return "Cover the person with a blanket to keep them warm."
            case 2: return "Encourage slow, steady breathing and reassure them."
            case 3: return "Seek medical attention immediately."
            case 4: return "Do not give the person anything to eat or drink unless instructed by medical professionals."
            case 5: return "Monitor the person's breathing and pulse closely."
            case 6: return "If the person becomes unconscious, check for a pulse and begin CPR if necessary."
            case 7: return "Turn the person on their side to prevent choking if they vomit."
            case 8: return "Loosen any restrictive clothing, such as belts or tight collars."
            case 9: return "Avoid giving the person caffeine or alcohol."
            case 10: return "Stay with the person until medical help arrives."
            default: return ""
            }
            
        case "Splinting Fractures":
            switch index {
            case 0: return "Immobilize the injured limb by using a splint or sturdy object."
            case 1: return "Make sure the splint extends above and below the fracture."
            case 2: return "Secure the splint with bandages or cloth to keep it in place."
            case 3: return "Seek medical help immediately to ensure proper treatment."
            case 4: return "Do not attempt to straighten a deformed limb."
            case 5: return "Check for circulation in the limb below the splint by checking for warmth and color."
            case 6: return "Pad the splint to prevent further injury to the skin."
            case 7: return "If the injury involves the head, neck, or spine, do not move the person unless absolutely necessary."
            case 8: return "Use pillows, blankets, or magazines as makeshift splints for smaller injuries."
            case 9: return "Learn basic splinting techniques to be prepared for emergencies."
            case 10: return "Remember that proper splinting can help prevent further injury and reduce pain."
            default: return ""
            }
            
        case "Using an AED":
            switch index {
            case 0: return "Turn on the AED and follow the voice prompts."
            case 1: return "Place the pads on the person's chest as indicated on the device."
            case 2: return "Allow the AED to analyze the person's heart rhythm."
            case 3: return "Deliver a shock if instructed by the AED, then resume CPR."
            case 4: return "Ensure the person is not touching the victim when delivering a shock."
            case 5: return "If the AED does not advise a shock, immediately resume CPR."
            case 6: return "Continue CPR cycles of 30 compressions and 2 breaths until the AED advises another shock or until medical professionals arrive."
            case 7: return "If available, use a second AED to improve the chances of survival."
            case 8: return "Do not interrupt CPR for more than 10 seconds to analyze the heart rhythm."
            case 9: return "Learn how to use an AED through proper training and practice."
            case 10: return "Early defibrillation with an AED significantly increases the chances of survival from sudden cardiac arrest."
            default: return ""
            }
            
        case "Treating Heat Stroke":
            switch index {
            case 0: return "Move the person to a cooler place, away from the heat."
            case 1: return "Remove excess clothing and cool the body with cold compresses or fans."
            case 2: return "Give the person fluids if they are conscious and able to drink."
            case 3: return "Seek immediate medical attention for severe cases."
            case 4: return "Cool the person gradually to avoid shivering, which can increase body temperature."
            case 5: return "Monitor the person's temperature closely."
            case 6: return "If the person is unconscious, do not give them anything to drink."
            case 7: return "Watch for signs of shock, such as rapid, weak pulse, cool clammy skin, and confusion."
            case 8: return "Prevent heat stroke by staying hydrated, avoiding strenuous activity during hot weather, and wearing light-colored, loose-fitting clothing."
            case 9: return "Seek medical attention immediately if the person experiences confusion, seizures, or loss of consciousness."
            case 10: return "Heat stroke is a medical emergency, and prompt action can save lives."
            default: return ""
            }
            
        case "Treating Hypothermia":
            switch index {
            case 0: return "Move the person to a warmer environment, out of the cold."
            case 1: return "Remove wet clothing and cover the person with warm blankets."
            case 2: return "Offer warm drinks (non-alcoholic) if the person is alert."
            case 3: return "Seek medical attention for severe hypothermia."
            case 4: return "Avoid rubbing the person's skin vigorously, as this can cause further damage."
            case 5: return "Do not apply direct heat to the skin, such as hot water bottles or heating pads."
            case 6: return "If the person is shivering uncontrollably, cover them with warm blankets and gently warm their core."
            case 7: return "Monitor the person's breathing and pulse closely."
            case 8: return "Prevent hypothermia by dressing warmly in layers, staying dry, and limiting exposure to cold temperatures."
            case 9: return "Seek medical attention immediately if the person is unconscious, confused, or has slurred speech."
            case 10: return "Hypothermia is a serious medical condition that can be life-threatening."
            default: return ""
            }
            
        case "RICE for Sprains":
            switch index {
            case 0: return "Rest the injured area and avoid putting weight on it."
            case 1: return "Apply ice to the injured area for 20-30 minutes to reduce swelling."
            case 2: return "Wrap the injury with an elastic bandage to compress the area."
            case 3: return "Elevate the injured limb to reduce swelling."
            case 4: return "Apply ice in 20-minute intervals, with 20-minute breaks in between."
            case 5: return "Use a cold pack or a bag of ice wrapped in a thin towel."
            case 6: return "Avoid applying ice directly to the skin."
            case 7: return "Compress the injury gently to reduce swelling, but not so tightly that it restricts circulation."
            case 8: return "Elevate the injured limb above the level of the heart whenever possible."
            case 9: return "Continue RICE treatment for the first 48 hours after the injury."
            case 10: return "Seek medical attention if the sprain is severe, if there is significant pain or swelling, or if you suspect a fracture."
            default: return ""
            }
            
        case "Treating Nosebleeds":
            switch index {
            case 0: return "Pinch the nostrils together and lean forward slightly."
            case 1: return "Breathe through the mouth while holding the nose."
            case 2: return "Apply a cold compress to the back of the neck or the nose to reduce bleeding."
            case 3: return "If bleeding doesn't stop after 20 minutes, seek medical help."
            case 4: return "Avoid picking your nose or blowing it forcefully."
            case 5: return "Avoid aspirin and other blood thinners if you have frequent nosebleeds."
            case 6: return "Use a humidifier to moisten the air, especially during dry weather."
            case 7: return "If the nosebleed is caused by injury, apply gentle pressure to the injured area."
            case 8: return "Seek medical attention if the nosebleed is severe, if it occurs frequently, or if it is accompanied by other symptoms such as fever, headache, or difficulty breathing."
            case 9: return "Avoid strenuous activity that may increase blood pressure."
            case 10: return "If you have frequent nosebleeds, consult with a doctor to determine the underlying cause."
            default: return ""
            }
            
        case "Eye Irrigation":
            switch index {
            case 0: return "Hold the affected eye under cool running water for several minutes."
            case 1: return "Blink frequently to help flush out the debris or chemical."
            case 2: return "If the irritation persists, seek medical attention."
            case 3: return "For chemical exposure, flush the eye for at least 15 minutes and seek urgent medical care."
            case 4: return "Tilt the head to the side of the affected eye to allow proper drainage."
            case 5: return "Use clean water or sterile saline solution for irrigation."
            case 6: return "Avoid rubbing the eye, as this can worsen the irritation."
            case 7: return "Remove any contact lenses before irrigating the eye."
            case 8: return "Cover the eye with a clean bandage after irrigation."
            case 9: return "Seek medical attention immediately if the eye injury is severe, if there is any pain, vision loss, or if the chemical exposure is significant."
            case 10: return "Learn basic eye irrigation techniques to be prepared for emergencies."
            default: return ""
            }
            
        default:
            return "Description for this technique is not available."
        }
    }
    
}

#Preview {
    techniquesDetailView(technique: .init(title: "CPR", description: "this is cpr", imageName: "CPR"))
}
