import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Image("ICSR2025_BANNER2")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 10)
                    
                    Text("Welcome message")
                        .font(.custom("Rajdhani-Bold", size: 28))
                        .foregroundColor(.black)
                    
                    ScrollView {
                        VStack(spacing: 40) {
                            Text("""
Dear Colleagues and Friends, It is with great pleasure that we invite you to the International Conference on Social Robotics + AI, taking place in the vibrant and historic city of Naples, Italy, from September 10 to 12, 2025. Now in its 17th edition, this prestigious event will bring together leading experts, researchers, and professionals from around the world to discuss the latest advancements in “Social Robotics and Artificial Intelligence”.

The conference theme, "Emotivation at the Core: Empowering Social Robots to Inspire and Connect", highlights the essential role of “Emotivation” in social robotics. Emotivation captures the synergy between emotion and motivation, where emotions trigger and sustain motivation during interactions. In social robotics, this concept is key to building trust, fostering empathy, and supporting decision-making by enabling robots to respond sensitively to human emotions, inspiring engagement and action.

For this year’s edition, we are excited to introduce several new elements designed to enhance your experience and enrich the discussions. We are confident these additions will provide fresh perspectives and offer new opportunities for interaction and collaboration.

The program will also feature a variety of sessions, including keynote speeches from world-renowned experts, technical presentations, workshops, and panel discussions, covering a broad spectrum of topics in robotics and AI.

Set in the enchanting city of Naples, known for its rich cultural heritage, exquisite cuisine, and vibrant atmosphere, the conference offers the perfect backdrop for professional growth and networking. A dedicated exhibition area will showcase the latest advancements in social robotics and AI, while a variety of social activities will provide ample opportunities to exchange ideas, build connections, and enjoy the unique charm of Naples.

We are excited to welcome you to this inspiring event at the forefront of Social Robotics and AI. Mark your calendars and join us for an unforgettable experience that blends cutting-edge innovation with the timeless beauty of Naples.

Warm regards,  
Mariacarla Staffa  
General Chair  
International Conference on Social Robotics + AI 2025.
""")
                                .font(.custom("Rajdhani-Regular", size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding()
                        }
                    }
                    .padding(.bottom, 10)
                    
                    NavigationLink(destination: HomepageView()) {
                        Text("Join us!")
                            .font(.custom("Rajdhani-Bold", size: 18))
                            .padding()
                            .background(Color(red: 0/255, green: 174/255, blue: 239/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

#Preview {
    WelcomePageView()
}
