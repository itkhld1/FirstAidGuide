//
//  SwiftUIView.swift
//  FirstAidGuide
//
//  Created by itkhld on 2024-11-08.
//

import SwiftUI

struct HelpGuide: Identifiable {
    var id = UUID()
    var title: String
    var description: String
}

struct WhenToSeekHelpView: View {
    
    @State private var searchText = ""
    
    let guideItems: [HelpGuide] = [
        HelpGuide(title: "High Fever", description: "A persistent high fever above 103°F (39.4°C) or fever lasting more than a few days requires medical evaluation."),
        HelpGuide(title: "Severe Headache", description: "Seek help if you experience a sudden or severe headache, especially if it is the worst headache of your life. This could indicate a serious issue."),
        HelpGuide(title: "Severe Abdominal Pain", description: "Unexplained or severe abdominal pain, especially if it's sudden and intense, may require urgent medical attention."),
        HelpGuide(title: "Sudden Vision Changes", description: "Sudden loss of vision, blurred vision, or seeing flashes could indicate a medical emergency. Seek help promptly."),
        HelpGuide(title: "Difficulty Speaking or Understanding Speech", description: "If you suddenly struggle with speech or understanding, it may be a sign of a stroke. Seek emergency care immediately."),
        HelpGuide(title: "Sudden Numbness or Paralysis", description: "Sudden numbness, weakness, or paralysis on one side of the body could indicate a stroke. Seek emergency medical attention."),
        HelpGuide(title: "Severe Back Pain", description: "If you experience severe back pain, especially if it radiates to the legs or is accompanied by weakness, seek medical help."),
        HelpGuide(title: "Severe Burns", description: "Third-degree burns or large second-degree burns require emergency care. Seek immediate medical attention."),
        HelpGuide(title: "Severe Vomiting or Diarrhea", description: "Persistent or severe vomiting or diarrhea can lead to dehydration and may require urgent care, especially if accompanied by blood."),
        HelpGuide(title: "Persistent Chest Discomfort", description: "Chest discomfort that comes and goes, or pressure in the chest, may be a warning sign of a heart problem. Seek medical help."),
        HelpGuide(title: "Persistent Coughing or Coughing Blood", description: "A chronic cough or coughing up blood could indicate a serious respiratory or cardiac condition. Consult a doctor."),
        HelpGuide(title: "Unusual Swelling", description: "Unexpected swelling in the face, limbs, or abdomen could indicate an underlying issue. Seek help, especially if it progresses."),
        HelpGuide(title: "Sudden Severe Pain in a Joint", description: "If you experience sudden, severe joint pain, especially after injury, it may require medical attention."),
        HelpGuide(title: "Changes in Skin or Moles", description: "If a mole or spot on the skin changes size, color, or shape, or starts bleeding, it could indicate skin issues. Consult a healthcare provider."),
        HelpGuide(title: "Severe Dehydration Symptoms", description: "Symptoms like dizziness, dry mouth, and confusion can indicate severe dehydration. Seek medical help if you can't keep fluids down."),
        HelpGuide(title: "Seizures", description: "If you or someone around you experiences a seizure for the first time, it is essential to seek medical attention."),
        HelpGuide(title: "Sudden Memory Loss or Confusion", description: "Sudden memory loss, confusion, or disorientation can indicate a neurological emergency. Seek immediate help."),
        HelpGuide(title: "Poisoning or Overdose", description: "In cases of suspected poisoning or overdose, call emergency services or visit the nearest emergency room."),
        HelpGuide(title: "Severe Depression or Suicidal Thoughts", description: "If you are experiencing severe depression or thoughts of self-harm, seek help from a mental health professional or helpline."),
        HelpGuide(title: "Inability to Urinate", description: "If you suddenly cannot urinate despite feeling the urge, it could indicate a blockage or infection. Seek medical attention."),
        HelpGuide(title: "Severe Leg or Arm Pain", description: "Severe pain in the limbs, especially after an accident or injury, could indicate a fracture or other serious issue. Seek medical help."),
        HelpGuide(title: "Breathing Difficulty", description: "Sudden shortness of breath or difficulty breathing could indicate an emergency condition, such as an asthma attack or allergic reaction."),
        HelpGuide(title: "Severe Allergic Reaction", description: "Severe allergic reactions, especially with swelling of the face, lips, or throat, may require immediate medical attention."),
        HelpGuide(title: "Loss of Consciousness", description: "If someone loses consciousness or becomes unresponsive, seek emergency medical help right away."),
        HelpGuide(title: "Severe Pain While Breathing", description: "Pain that worsens when breathing deeply could indicate a lung issue, like a blood clot or infection. Seek help immediately."),
        HelpGuide(title: "Severe Toothache", description: "Persistent, severe tooth pain may require emergency dental care to prevent further complications."),
        HelpGuide(title: "Severe Anxiety or Panic Attacks", description: "If anxiety or panic attacks are interfering with your ability to function or causing severe physical symptoms, seek support from a healthcare provider."),
        HelpGuide(title: "Persistent Nosebleed", description: "A nosebleed that doesn't stop after 10-15 minutes, especially if accompanied by dizziness, requires medical evaluation."),
        HelpGuide(title: "Severe Menstrual Bleeding", description: "If you experience heavy menstrual bleeding that soaks through clothing or lasts longer than usual, seek medical attention."),
        HelpGuide(title: "Severe Weakness or Fatigue", description: "Extreme weakness, fatigue, or difficulty staying awake could indicate a medical condition such as anemia or a heart issue. Seek help if it persists."),
        HelpGuide(title: "Trouble Swallowing", description: "If you experience pain or difficulty swallowing, it could indicate a throat infection or other serious issue. Seek help if this happens suddenly."),
        HelpGuide(title: "Unexplained Weight Loss", description: "Unexplained weight loss, especially when accompanied by fatigue or other symptoms, could indicate a medical condition that requires evaluation."),
        HelpGuide(title: "Severe Heartburn", description: "If you experience severe, persistent heartburn or chest pain, it could be a sign of a more serious condition like a heart attack or acid reflux. Seek help."),
        HelpGuide(title: "Sudden Onset of High Blood Pressure", description: "A sudden spike in blood pressure can lead to a stroke or other issues. Seek medical help if blood pressure readings are dangerously high."),
        HelpGuide(title: "Uncontrollable Bleeding", description: "Uncontrollable bleeding from a wound that doesn't stop despite applying pressure may require immediate medical assistance."),
        HelpGuide(title: "Severe Head Trauma", description: "Severe trauma to the head, especially if unconsciousness or confusion follows, may indicate a concussion or brain injury. Seek medical help."),
        HelpGuide(title: "Sudden Sweating or Cold Sweats", description: "Sudden, unexplained sweating or cold sweats could indicate a heart problem or infection. Seek medical attention if this occurs."),
        HelpGuide(title: "Sudden High Blood Sugar", description: "A sudden spike in blood sugar levels can cause symptoms such as confusion, thirst, and frequent urination. Seek help if these symptoms appear."),
        HelpGuide(title: "Unexplained Cough or Chest Pain", description: "A persistent cough or chest pain that is unexplained may be a sign of a respiratory issue or heart problem. Seek medical evaluation."),
        HelpGuide(title: "Numbness in Hands or Feet", description: "Sudden numbness, tingling, or weakness in the extremities could indicate a neurological issue or stroke. Seek help immediately."),
        HelpGuide(title: "Severe Diabetic Symptoms", description: "If you have diabetes and experience extreme symptoms like confusion, dizziness, or excessive thirst, seek immediate medical help."),
        HelpGuide(title: "Severe Muscle Pain", description: "Severe muscle pain that comes on suddenly, especially after physical activity or injury, could indicate a muscle tear or strain. Seek medical care."),
        HelpGuide(title: "Excessive Thirst or Urination", description: "Excessive thirst or urination can be a sign of uncontrolled diabetes or kidney issues. Seek medical attention if these symptoms are severe."),
        HelpGuide(title: "Lacerations or Deep Wounds", description: "Deep cuts or lacerations that won't stop bleeding or that expose underlying tissue require immediate medical care."),
        HelpGuide(title: "Broken Bones", description: "If you suspect you have a broken bone, especially in an arm or leg, seek medical attention for proper care."),
        HelpGuide(title: "Severe Ankle or Knee Injury", description: "A severe injury to the ankle or knee, especially with swelling and inability to move the joint, may require medical treatment."),
        HelpGuide(title: "Severe Head or Neck Pain", description: "Severe pain in the head or neck that doesn't improve may indicate a serious issue like a brain injury or infection. Seek help."),
        HelpGuide(title: "Heatstroke", description: "Symptoms of heatstroke, such as confusion, dizziness, or nausea, require immediate medical attention. Call emergency services."),
        HelpGuide(title: "Stab Wounds", description: "A stabbing injury may result in serious damage to internal organs. Apply pressure to the wound and seek emergency medical care."),
        HelpGuide(title: "Broken Teeth", description: "Broken or severely damaged teeth from an accident or injury require urgent dental care."),
        HelpGuide(title: "Eye Injuries", description: "Any injury to the eye, including trauma or chemical exposure, needs immediate evaluation by a healthcare provider."),
        HelpGuide(title: "Loss of Appetite", description: "Unexplained loss of appetite, especially when associated with other symptoms like fatigue or weight loss, requires a medical assessment."),
        HelpGuide(title: "Bowel Obstruction", description: "If you experience severe abdominal bloating, pain, or vomiting, it could indicate a bowel obstruction. Seek medical help."),
        HelpGuide(title: "Uncontrolled Fever in Children", description: "A fever in a young child that is unusually high or lasts longer than 24 hours may require immediate medical care."),
        HelpGuide(title: "Toxic Inhalation", description: "Breathing in harmful substances, such as smoke or chemicals, can lead to respiratory distress. Seek help immediately."),
        HelpGuide(title: "Excessive Bleeding from Gums", description: "Excessive gum bleeding, especially when brushing teeth, may indicate a serious condition like a blood clotting disorder. Seek medical care."),
        HelpGuide(title: "Throat Tightness", description: "If you feel tightness in your throat or difficulty swallowing, it may indicate an allergic reaction or airway obstruction. Seek medical help."),
        HelpGuide(title: "Unexplained Bruising", description: "Unexplained bruising, especially if it's widespread, can indicate a bleeding disorder or other serious health issues. Seek evaluation."),
        HelpGuide(title: "Severe Mouth Pain", description: "Pain in the mouth that doesn't resolve, especially with swelling or difficulty swallowing, may require urgent dental or medical care.")
    ]
    
    var filteredGuides: [HelpGuide] {
        if searchText.isEmpty {
            return guideItems
        } else {
            return guideItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack(spacing: 16) {
                    
                    SearchBar(text: $searchText)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(filteredGuides) { guide in
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack(alignment: .center, spacing: 16) {
                                        Image(systemName: getSymbolForCondition(guide.title))
                                            .font(.title2)
                                            .foregroundColor(.red)
                                            .frame(width: 24, height: 24)
                                            .padding(8)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.red.opacity(0.1))
                                            )
                                            .frame(width: 44, height: 44)
                                        
                                        Text(guide.title)
                                            .font(.headline)
                                            .foregroundColor(Color("FontColor"))
                                            .lineLimit(1)
                                        
                                        Spacer()
                                    }
                                    
                                    Text(guide.description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineSpacing(4)
                                        .padding(.leading, 60)
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color("Color"))
                                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                )
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
            .navigationTitle("When to Seek Help")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func getSymbolForCondition(_ title: String) -> String {
        switch title.lowercased() {
        case let t where t.contains("fever"):
            return "thermometer.high"
        case let t where t.contains("headache"):
            return "brain.head.profile"
        case let t where t.contains("abdominal"):
            return "stethoscope.circle"
        case let t where t.contains("vision"):
            return "eye"
        case let t where t.contains("speech"):
            return "mouth"
        case let t where t.contains("numbness"):
            return "figure.walk"
        case let t where t.contains("back"):
            return "figure.walk.motion"
        case let t where t.contains("burns"):
            return "flame"
        default:
            return "staroflife.fill"
        }
    }
}

#Preview {
    WhenToSeekHelpView()
}

