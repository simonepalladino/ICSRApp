import SwiftUI
import SafariServices

struct HomepageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showSafari = false
    @State private var safariURL: URL?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(.custom("Rajdhani-Bold", size: 16))
                            .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.top, -25)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    HStack(spacing: 15) {
                        NavigationLink(destination: OverviewPageView()) {
                            MenuButton(title: "Overview")
                        }
                        NavigationLink(destination: ContactPageView()) {
                            MenuButton(title: "Contact")
                        }
                    }
                    HStack(spacing: 15) {
                        NavigationLink(destination: ProgramPageView()) {
                            MenuButton(title: "Program")
                        }
                        NavigationLink(destination: RegisterPageView()) {
                            MenuButton(title: "Register")
                        }
                    }
                    HStack(spacing: 15) {
                        NavigationLink(destination: VenuePageView()) {
                            MenuButton(title: "Venue")
                        }
                        NavigationLink(destination: DeadlinePageView()) {
                            MenuButton(title: "Deadlines dates")
                        }
                    }
                    HStack(spacing: 15) {
                        NavigationLink(destination: EsploraPageView()) {
                            MenuButton(title: "Explore Naples")
                        }
                        Button(action: {
                                safariURL = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScWDd6TZrjM9svvlxtgLHxOoNwIL-2B3O8X4qHo0ZSKIR2imw/viewform?usp=dialog")
                                showSafari = true
                            }) {
                                MenuButton(title: "Questionary")
                            }
                    }
                    .padding(.bottom, 60)

                    VStack {
                        Text("Follow ICSR 2025 on Social Media")
                            .font(.custom("Rajdhani-Regular", size: 16))
                            .foregroundColor(.black)
                        HStack {
                            Button(action: {
                                safariURL = URL(string: "https://www.linkedin.com/company/icsr25/")
                                showSafari = true
                            }) {
                                Image("linkedinlogo")
                                    .resizable()
                                    .padding()
                                    .frame(width: 70, height: 70)
                            }

                            Button(action: {
                                safariURL = URL(string: "https://x.com/icsr2025?s=21")
                                showSafari = true
                            }) {
                                Image("xlogo")
                                    .resizable()
                                    .padding()
                                    .frame(width: 70, height: 70)
                            }

                            Button(action: {
                                safariURL = URL(string: "https://www.instagram.com/icsr2025?igsh=ejVoaGxwd25yNG9k")
                                showSafari = true
                            }) {
                                Image("instagramlogo")
                                    .resizable()
                                    .padding()
                                    .frame(width: 70, height: 70)
                            }
                        }
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Image("ICSR2025_BANNER2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .sheet(isPresented: $showSafari) {
                if let url = safariURL {
                    SafariView(url: url)
                }
            }
        }
    }
}

struct MenuButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.custom("Rajdhani-Bold", size: 16))
            .foregroundColor(.white)
            .frame(width: 140, height: 50)
            .background(Color(red: 0/255, green: 174/255, blue: 239/255))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
    }
}

#Preview {
    HomepageView()
}
