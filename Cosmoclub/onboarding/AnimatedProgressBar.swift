//
//  AnimatedProgressBar.swift
//  Cosmoclub
//
//  Created by Admin on 26/4/2568 BE.
//

import SwiftUI

struct AnimatedProgressBar: View {
    var progress: Double
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(height: 10)
                .foregroundStyle(.white.opacity(0.2))
            Capsule()
                .frame(width: CGFloat(progress) * 200, height: 10)
                .foregroundStyle(.white)
                .shadow(color: .white, radius: 8)
            Circle()
                .fill(LinearGradient(colors: [.white, .clear], startPoint: .leading, endPoint: .trailing))
                .frame(width: 14, height: 14)
                .offset(x: CGFloat(progress) * 200 - 7)
                .blur(radius: 2)
                .animation(.easeInOut(duration: 0.5), value: progress)
        }
        .frame(width: 200)
        .padding(.top, 10)

    }
}

#Preview {
    AnimatedProgressBar(progress: 0.2)
        .background(.black)
}
