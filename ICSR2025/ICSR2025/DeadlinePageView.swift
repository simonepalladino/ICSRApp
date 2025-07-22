//
//  DeadlinePageView.swift
//  ICSR2025
//
//  Created by Simone Palladino on 17/03/25.
//

import SwiftUI

struct DeadlinePageView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 230/255, green: 241/255, blue: 253/255)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("DEADLINES DATES")
                            .font(.custom("Rajdhani-Bold", size: 30))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 60)
                        
                        Text("Full paper submission")
                            .font(.custom("Rajdhani-SemiBold", size: 22))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text("March 28th 2025")
                            .font(.custom("Rajdhani-Regular", size: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Short paper submission")
                            .font(.custom("Rajdhani-SemiBold", size: 22))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text("May 16th 2025")
                            .font(.custom("Rajdhani-Regular", size: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Special session paper submission")
                            .font(.custom("Rajdhani-SemiBold", size: 22))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text("March 28th 2025")
                            .font(.custom("Rajdhani-Regular", size: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 20)
                    
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
    DeadlinePageView()
}
