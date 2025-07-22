import SwiftUI
import SafariServices

struct RegisterPageView: View {
    @Environment(\.dismiss) var dismiss

    @State private var showSafari = false
    @State private var safariURL: URL?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    // Titolo fuori dal riquadro
                    Text("How to participate")
                        .font(.custom("Rajdhani-Bold", size: 26))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)

                    // Unico riquadro
                    VStack(spacing: 30) {
                        // Step 1
                        VStack(spacing: 10) {
                            Text("Register on the official website.")
                                .font(.custom("Rajdhani-SemiBold", size: 20))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)

                            Button(action: {
                                if let url = URL(string: "https://www.frcongressi.it/pay/user/areapersonale.php?token=ebfac0ff4d5f7b175aa81dd631915541") {
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
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.95))
                    .cornerRadius(20)
                    .shadow(radius: 8)
                    .padding(.horizontal)

                    Spacer()

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
                .navigationBarBackButtonHidden(true)
                .safeAreaInset(edge: .top) {
                    Image("ICSR2025_BANNER2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
                .sheet(isPresented: $showSafari) {
                    if let url = safariURL {
                        SafariView(url: url)
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterPageView()
}
