import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <!DOCTYPE html>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
            }
            iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }
        </style>
        </head>
        <body>
            <iframe src="https://www.youtube.com/embed/\(videoID)?playsinline=1"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

struct AppInfoView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    Image("ICSR_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 5)

                    VStack(alignment: .leading, spacing: 12) {
                        Label("ICSR 2025 App", systemImage: "app.fill")
                            .font(.custom("Rajdhani-Bold", size: 20))
                            .foregroundColor(.black)

                        Label("Developer: Simone Palladino", systemImage: "person.fill")
                            .foregroundColor(.black)
                            .font(.custom("Rajdhani-SemiBold", size: 20))
                        Label("Version: 1.0.0", systemImage: "gearshape.fill")
                            .foregroundColor(.black)
                            .font(.custom("Rajdhani-SemiBold", size: 20))
                        Label("Event: ICSR 2025", systemImage: "mappin.and.ellipse")
                            .foregroundColor(.black)
                            .font(.custom("Rajdhani-SemiBold", size: 20))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(red: 230/255, green: 241/255, blue: 253/255))
                    .cornerRadius(20)
                    .shadow(radius: 5)

                    Spacer()
                }
                .padding()
                .background(Color(red: 230/255, green: 241/255, blue: 253/255))
            }
            .navigationTitle("App Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("App Information")
                        .font(.custom("Rajdhani-Bold", size: 20))
                        .foregroundColor(.black)
                }
            }
            .background(Color(red: 230/255, green: 241/255, blue: 253/255))
        }
    }
}




struct OverviewPageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showInfoSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Image("ICSR2025_BANNER2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)

                    ScrollView {
                        VStack(spacing: 25) {
                            YouTubeView(videoID: "ApJzNO1-3TE")
                                .frame(height: 200)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .padding(.horizontal)

                            Text("""
                            Welcome to the official ICSR 2025 app, your essential companion for navigating the conference! Designed for academics, professionals, and robotics enthusiasts, this app puts everything you need for ICSR 2025 at your fingertips.
                            """)
                            .font(.custom("Rajdhani-SemiBold", size: 16))
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                            .padding(.horizontal)

                            Button(action: {
                                showInfoSheet = true
                            }) {
                                VStack {
                                    Image(systemName: "info.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.blue)
                                    Text("App Info")
                                        .font(.custom("Rajdhani-Bold", size: 16))
                                        .foregroundColor(.blue)
                                }
                                .padding(10)
                                .shadow(radius: 4)
                            }
                        }
                        .padding(.top, 20)
                    }

                    Button(action: {
                        dismiss()
                    }) {
                        Image("iconhome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .foregroundColor(.black)
                    }
                    .padding(.bottom, 20)
                }
            }
            .sheet(isPresented: $showInfoSheet) {
                AppInfoView()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    OverviewPageView()
}
