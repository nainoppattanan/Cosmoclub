//
//  OnboardLayer.swift
//  Cosmoclub
//
//  Created by Admin on 26/4/2568 BE.
//

import SwiftUI

struct OnboardLayer: View {
    let imagename: String
    let text: String
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image(imagename)
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)
                .shadow(radius: 20)
                .transition(.opacity.combined(with: .scale))
            Text(text)
                .font(.title2)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    OnboardLayer(imagename: "onboarding1", text: "Apiphoom")
        .background(.black)
}
