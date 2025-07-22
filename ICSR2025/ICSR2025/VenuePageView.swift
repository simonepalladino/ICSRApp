//
//  VenuePageView.swift
//  ICSR2025
//
//  Created by Simone Palladino on 17/03/25.
//

import SwiftUI

struct VenuePageView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    Text("How to reach the Venue")
                        .font(.custom("Rajdhani-Bold", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    ScrollView {
                        Text("By Plane")
                            .font(.custom("Rajdhani-Semibold", size: 18))
                            .foregroundColor(.black)
                        Text("""
                        Naples International Airport (Capodichino) is located about 7 km from the city center. It offers direct flights to and from major European cities. Upon arrival, you can take the Alibus shuttle (running every 20-30 minutes) to Napoli Centrale Station or Piazza Municipio. Alternatively, taxis are available at the terminal, with fixed fares to the city center (around €25). For more convenience, car rental services and private transfers are also available.
                        """)
                        .font(.custom("Rajdhani-Regular", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding()
                        
                        
                        Text("By Train")
                            .font(.custom("Rajdhani-Semibold", size: 18))
                            .foregroundColor(.black)
                        Text("""
                        Naples is a major railway hub, easily reachable from cities like Rome, Florence, or Milan via high-speed trains such as Frecciarossa or Italo. Trains arrive at Napoli Centrale Station, which is centrally located in Piazza Garibaldi. From there, you can access metro lines, buses, or taxis to reach your final destination. Regional trains also connect Naples to nearby attractions such as Pompeii and Sorrento.
                        """)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .font(.custom("Rajdhani-Regular", size: 16))
                        .foregroundColor(.black)
                        
                        
                        Text("By Car")
                            .font(.custom("Rajdhani-Semibold", size: 18))
                            .foregroundColor(.black)
                        Text("""
                        Naples is well-connected by motorways. From Rome, take the A1 (Autostrada del Sole), which takes about 2-2.5 hours. From the south, use the A3 motorway from Salerno or the Amalfi Coast. Be aware that driving in Naples can be challenging due to heavy traffic and narrow streets. Parking is limited in the city center, so consider using public garages or parking outside the central area and relying on public transport to explore the city.
                        """)
                        .font(.custom("Rajdhani-Regular", size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .padding()
                        
                        
                        Text("Main air connections")
                            .font(.custom("Rajdhani-Semibold", size: 18))
                            .foregroundColor(.black)
                        Image("mainairconn")
                            .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .padding()
                    }
                    
                    Spacer()
                    
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
                    .padding(.bottom, 20)
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

#Preview {
    VenuePageView()
}
