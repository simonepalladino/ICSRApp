import SwiftUI

struct ContactPageView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer(minLength: 16)
                    
                    Text("Contact Information")
                        .font(.custom("Rajdhani-Bold", size: 24))
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ContactBox(
                            icon: "envelope",
                            title: "Registration, Accommodation & logistic information",
                            email: "info@icsr2025.eu"
                        )
                        ContactBox(
                            icon: "brain.head.profile",
                            title: "Scientific Issues",
                            email: "tpc@icsr2025.eu"
                        )
                        ContactBox(
                            icon: "c.circle",
                            title: "Competitions",
                            email: "competition@icsr2025.eu"
                        )
                        ContactBox(
                            icon: "person.3",
                            title: "Social Media",
                            email: "socialmedia@icsr2025.eu"
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()}) {
                        Image("iconhome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 60)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                    }
                }
                .safeAreaInset(edge: .top) {
                    Image("ICSR2025_BANNER2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ContactBox: View {
    var icon: String
    var title: String
    var email: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding()
                .background(Circle().fill(Color(red: 4/255, green: 255/255, blue: 127/255)))
                .frame(height: 60)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.custom("Rajdhani-Bold", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .frame(maxHeight: 50)
                    .fixedSize(horizontal: false, vertical: true)
                
                Link(destination: URL(string: "mailto:\(email)")!) {
                    Text(email)
                        .font(.custom("Rajdhani-Regular", size: 14))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 170, alignment: .top)
        .padding()
        .background(Color(red: 0/255, green: 174/255, blue: 239/255))
        .cornerRadius(16)
    }
}



#Preview {
    ContactPageView()
}
