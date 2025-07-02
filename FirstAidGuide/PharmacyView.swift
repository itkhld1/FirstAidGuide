//
//  PharmacyView.swift
//  FirstAidGuide
//
//  Created by itkhld on 24.12.2024.
//

import SwiftUI
import MapKit

struct PharmacyView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var pharmacies: [MKMapItem] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                if let userLocation = locationManager.userLocation {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(pharmacies, id: \.self) { pharmacy in
                                Button(action: {
                                    openInMaps(pharmacy: pharmacy)
                                }) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "cross.case.fill")
                                            .font(.title2)
                                            .foregroundColor(.green)
                                            .frame(width: 40, height: 40)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.green.opacity(0.1))
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(pharmacy.name ?? "Unknown")
                                                .font(.headline)
                                                .foregroundColor(Color("FontColor"))

                                            Text(pharmacy.placemark.title ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                            .font(.system(.subheadline, weight: .semibold))
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color("Color"))
                                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                    .onAppear {
                        fetchNearbyHospitals(location: userLocation) { results in
                            self.pharmacies = results
                        }
                    }
                } else if let error = locationManager.locationError {
                    VStack {
                        Image(systemName: "location.slash.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                            .padding()
                        
                        Text("Location Error")
                            .font(.headline)
                        
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                        
                        Text("Finding nearby pharmacies...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
            }
            .navigationTitle("Nearby Pharmacies")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                locationManager.requestLocation()
            }
        }
    }
    
    // Function to open a hospital location in Apple Maps
    private func openInMaps(pharmacy: MKMapItem) {
        let mapItem = pharmacy
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }

    // Example function to fetch nearby hospitals
    private func fetchNearbyHospitals(location: CLLocation, completion: @escaping ([MKMapItem]) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Pharmacy"
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error fetching pharmacies: \(error.localizedDescription)")
                completion([])
                return
            }
            completion(response?.mapItems ?? [])
        }
    }
}

#Preview {
    PharmacyView()
}
