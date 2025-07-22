import SwiftUI
import MapKit
import SafariServices

struct EsploraPageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var recommendedPlaces: [RecommendedPlace] = []
    @State private var allPlaces: [RecommendedPlace] = []
    @State private var searchText: String = ""
    @State private var selectedPlace: RecommendedPlace?

    // Stato per gestire la modalità: raccomandazioni o tutti i luoghi
    @State private var isShowingRecommendations: Bool = true

    @State private var showSafari = false
    @State private var safariURL: URL?

    var filteredPlaces: [RecommendedPlace] {
        if searchText.isEmpty {
            return Array((isShowingRecommendations ? recommendedPlaces : allPlaces).prefix(30))
        } else {
            return (isShowingRecommendations ? recommendedPlaces : allPlaces).filter { place in
                place.tags.lowercased().split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    .contains(where: { $0.contains(searchText.lowercased()) })
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()

                VStack(spacing: 10) {
                    Text("Explore Naples")
                        .font(.custom("Rajdhani-Bold", size: 22))
                        .foregroundColor(.black)
                        .padding(.top, 20)

                    // Toggle per alternare tra raccomandazioni e tutti i luoghi
                    Toggle("Show Recommendations", isOn: $isShowingRecommendations)
                        .font(.custom("Rajdhani-SemiBold", size: 20))
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        .padding()
                        .foregroundColor(.black)
                        .onChange(of: isShowingRecommendations) { _ in
                            // Controlla se i dati corretti sono già caricati
                            if !isShowingRecommendations && allPlaces.isEmpty {
                                fetchAllPlaces(luogoId: 1)
                            }
                        }

                    TextField("Search by tag... (e.g. Sea, Historical)", text: $searchText)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(filteredPlaces) { place in
                                Button(action: {
                                    selectedPlace = place
                                }) {
                                    placeCard(place)
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        Text("Can't find what you're looking for?")
                            .font(.custom("Rajdhani-Regular", size: 14))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)

                        Button(action: {
                            if let url = URL(string: "https://www.comune.napoli.it/aree-tematiche") {
                                safariURL = url
                                showSafari = true
                            }
                        }) {
                            Text("Click here")
                                .font(.custom("Rajdhani-Bold", size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 0/255, green: 174/255, blue: 239/255))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 20)
                        .sheet(isPresented: $showSafari) {
                            if let url = safariURL {
                                SafariView(url: url)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 20)

                    Button(action: { dismiss() }) {
                        Image("iconhome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                    }
                    .padding(.bottom, 20)
                }

                if let place = selectedPlace {
                    DetailView(place: place, selectedPlace: $selectedPlace)
                }
            }
            .safeAreaInset(edge: .top) {
                Image("ICSR2025_BANNER2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .onAppear {
                // Carica entrambi i dati all'inizio
                fetchRecommendedPlaces(luogoId: 1)
                fetchAllPlaces(luogoId: 1)
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    struct RecommendedPlace: Identifiable, Codable {
        var id: Int
        let nome: String
        let descrizione: String
        let tags: String
        let lat: Double?
        let lon: Double?
    }

    private func placeCard(_ place: RecommendedPlace) -> some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .padding()

            VStack(alignment: .leading, spacing: 5) {
                Text(place.nome)
                    .font(.custom("Rajdhani-Bold", size: 18))
                    .foregroundColor(.white)

                Text(place.tags)
                    .font(.custom("Rajdhani-Regular", size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.8))
            }

            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.7)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    func fetchRecommendedPlaces(luogoId: Int) {
        guard let url = URL(string: "http://IP:10000/consiglia?luogo_id=\(luogoId)&top_n=30") else {
            print("URL non valido")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Errore nella richiesta: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Nessun dato ricevuto")
                return
            }

            do {
                let jsonResponse = try JSONDecoder().decode([String: [RecommendedPlace]].self, from: data)
                DispatchQueue.main.async {
                    self.recommendedPlaces = jsonResponse["recommendations"] ?? []
                }
            } catch {
                print("Errore nella decodifica del JSON:", error)
            }
        }.resume()
    }

    func fetchAllPlaces(luogoId: Int) {
        guard let url = URL(string: "IP:10000/tutti_luoghi?luogo_id=\(luogoId)&top_n=30&top_n=30") else {
            print("URL non valido")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Errore nella richiesta: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Nessun dato ricevuto")
                return
            }

            do {
                let jsonResponse = try JSONDecoder().decode([String: [RecommendedPlace]].self, from: data)
                DispatchQueue.main.async {
                    self.allPlaces = jsonResponse["all_places"] ?? []
                }
            } catch {
                print("Errore nella decodifica del JSON:", error)
            }
        }.resume()
    }
}

struct DetailView: View {
    var place: EsploraPageView.RecommendedPlace
    @Binding var selectedPlace: EsploraPageView.RecommendedPlace?

    var body: some View {
        VStack {
            Text(place.nome)
                .font(.custom("Rajdhani-Bold", size: 24))
                .foregroundColor(.black)
                .padding()
            ScrollView {
                Text(place.descrizione)
                    .font(.custom("Rajdhani-Regular", size: 20))
                    .foregroundColor(.gray)
                    .padding()
                Text("Tags: \(place.tags)")
                    .font(.custom("Rajdhani-Regular", size: 16))
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()

            if let lat = place.lat, let lon = place.lon {
                Button(action: {
                    openInAppleMaps(latitude: lat, longitude: lon)
                }) {
                    Text("Open in Maps")
                        .font(.custom("Rajdhani-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }

            Button(action: {
                selectedPlace = nil
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .padding()
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding()
    }

    func openInAppleMaps(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        mapItem.name = place.nome
        mapItem.openInMaps(launchOptions: [:])
    }
}

// MARK: - SafariView (Browser in-app)
struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

// MARK: - Anteprima
#Preview {
    EsploraPageView()
}
