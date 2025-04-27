//
//  FloatingParticles.swift
//  Cosmoclub
//
//  Created by Admin on 26/4/2568 BE.
//

import SwiftUI

struct FloatingParticles: View {
    @State private var animate = false
    var body: some View {
        GeometryReader {geo in
            ZStack {
                ForEach(0..<30, id:\.self) {i in
                    Circle()
                        .fill(.white.opacity(0.3))
                        .frame(width: CGFloat.random(in: 5...10), height: CGFloat.random(in: 5...10))
                        .position(x: CGFloat.random(in: 0...geo.size.width), y: animate ? -20: geo.size.height + 20)
                        .animation(.easeInOut(duration: Double.random(in: 8...15))
                            .repeatForever(autoreverses: false)
                            .delay(Double(i) * 0.2), value: animate
                        
                        )
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {animate = true}
    }
}

#Preview {
    FloatingParticles()
}
