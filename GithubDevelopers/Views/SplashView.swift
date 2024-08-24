//
//  SplashView.swift
//  GithubDevelopers
//
//  Created by Muhammed Elşami on 19.08.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            if isActive {
                HomeView()
            } else {
                VStack {
                    Image(systemName: "person.3.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.5)) {
                                self.scale = 1.0
                                self.opacity = 1.0
                            }
                        }
                    Text("DevFinder")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
