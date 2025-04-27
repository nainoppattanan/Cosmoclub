//
//  OnboardView.swift
//  Cosmoclub
//
//  Created by Admin on 26/4/2568 BE.
//

import SwiftUI

struct OnboardView: View {
    @State private var currentPage = 0
    var body: some View {
        ZStack {
            FloatingParticles()
            VStack(spacing: 20) {
                AnimatedProgressBar(progress: Double(min(currentPage, 2)) / 2)
                TabView(selection: $currentPage) {
                    OnboardLayer(imagename: "onboarding1", text: "🟢⚫️\nExplore the cosmos with us").tag(0)
                    OnboardLayer(imagename: "onboarding2", text: "🟢🟢\nWorld hello").tag(1)
                    RegisterPage(currentPage: $currentPage).tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.5), value: currentPage)
            }
        }
        .background(
            LinearGradient(colors: [.black, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    OnboardView()
}
