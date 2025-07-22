//
//  ProgramPageView.swift
//  ICSR2025
//
//  Created by Simone Palladino on 17/03/25.
//

import SwiftUI
import MapKit

// MARK: - Struct per posizione selezionata
struct MapLocation {
    var latitude: Double
    var longitude: Double
    var name: String
}

// MARK: - UIViewRepresentable per la mappa
struct AppleMapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
    let onTap: () -> Void

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .hybrid

        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.mapTapped))
        mapView.addGestureRecognizer(tapGesture)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        uiView.setRegion(region, animated: false)

        uiView.removeAnnotations(uiView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        uiView.addAnnotation(annotation)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onTap: onTap)
    }

    class Coordinator: NSObject {
        let onTap: () -> Void

        init(onTap: @escaping () -> Void) {
            self.onTap = onTap
        }

        @objc func mapTapped() {
            onTap()
        }
    }
}

struct ProgramPageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showMapAlert: Bool = false
    @State private var selectedMapLocation: MapLocation? = nil

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Image("ICSR2025_BANNER2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 30)

                    ScrollView {
                        VStack(spacing: 20) {
                            VStack(spacing: 0) {
                                tableRow(day: "DAY 1", event: "Welcome aperitif")
                                Divider().background(Color.black)
                                tableRow(day: "DAY 2", event: "Social dinner")
                                Divider().background(Color.black)
                                tableRow(day: "DAY 3", event: "Closing party")
                            }
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .font(.custom("Rajdhani-Bold", size: 18))
                            .foregroundColor(.black)

                            Group {
                                Text("DAY 1-2")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                                
                                Text("On September 10th and 11th the conference will take place at the University of Naples Parthenope at the Centro Direzionale, Isola C4.")
                                    .font(.custom("Rajdhani-Regular", size: 16))
                                
                                Text("The university of Naples Parthenope")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                                
                                Text("The University of Naples Parthenope, founded in 1920, is a renowned institution located in the heart of Naples. It offers a wide range of undergraduate and postgraduate programs, with a focus on economics, law, engineering, and maritime studies. The university is known for its research excellence and strong ties to local and international industries. Its campuses provide a blend of historical and modern architecture, fostering a dynamic learning environment.")
                                    .font(.custom("Rajdhani-Regular", size: 16))
                                
                                Text("How to reach the university of Naples Parthenope")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)

                            AppleMapView(
                                coordinate: CLLocationCoordinate2D(latitude: 40.85687482980829, longitude: 14.284378108348044),
                                title: "Università degli Studi di Napoli Parthenope",
                                subtitle: "Centro Direzionale ISOLA C4, 80133 Napoli NA",
                                onTap: {
                                    selectedMapLocation = MapLocation(
                                        latitude: 40.85687482980829,
                                        longitude: 14.284378108348044,
                                        name: "University of Naples Parthenope"
                                    )
                                    showMapAlert = true
                                }
                            )
                            .frame(height: 250)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .padding(.bottom, 100)

                            Group {
                                Text("DAY 3")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                                
                                Text("On September 12th the conference will take place at the conference center of Città della Scienza, Sala Newton, Via Coroglio 57/104.")
                                    .font(.custom("Rajdhani-Regular", size: 16))
                                
                                Text("Città della scienza")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                                
                                Text("Città della Scienza, founded in 1996, is a renowned science museum and innovation hub located in the Bagnoli district of Naples. Built on a former industrial site, it symbolizes the area’s transformation into a center for education and culture. The museum features interactive exhibits on science, technology, and space, alongside a state-of-the-art 3D planetarium. It also hosts a modern congress center, making it a prime venue for conferences, workshops, and cultural events, all set against the backdrop of stunning coastal views.")
                                    .font(.custom("Rajdhani-Regular", size: 16))
                                
                                Text("How to reach Città della Scienza")
                                    .font(.custom("Rajdhani-Bold", size: 18))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal)

                            AppleMapView(
                                coordinate: CLLocationCoordinate2D(latitude: 40.80532627875058, longitude: 14.17429317113871),
                                title: "Città della scienza",
                                subtitle: "Via Coroglio, 57/104, 80124 Napoli NA",
                                onTap: {
                                    selectedMapLocation = MapLocation(
                                        latitude: 40.80532627875058,
                                        longitude: 14.17429317113871,
                                        name: "Città della Scienza"
                                    )
                                    showMapAlert = true
                                }
                            )
                            .frame(height: 250)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 35)

                    Button(action: {
                        dismiss()
                    }) {
                        Image("iconhome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                    }
                    .padding(.bottom, 15)
                }
                .navigationBarBackButtonHidden(true)
            }
            .alert("Open in Apple Maps?", isPresented: $showMapAlert) {
                Button("Open") {
                    if let location = selectedMapLocation {
                        openInAppleMaps(latitude: location.latitude, longitude: location.longitude, name: location.name)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }


    func tableRow(day: String, event: String) -> some View {
        HStack(spacing: 0) {
            Text(day)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)

            Divider()
                .frame(width: 1)
                .background(Color.black)

            Text(event)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
        }
    }

    
    func openInAppleMaps(latitude: Double, longitude: Double, name: String) {
        let destination = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    ProgramPageView()
}
