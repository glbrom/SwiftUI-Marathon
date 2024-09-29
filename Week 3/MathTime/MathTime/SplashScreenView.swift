//
//  SplashScreenView.swift
//  MathTime
//
//  Created by Roman Golub on 27.09.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            ZStack {
                VStack {
                    Image("SplashImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 850)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
