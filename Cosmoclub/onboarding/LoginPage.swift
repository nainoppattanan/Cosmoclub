//
//  RegisterPage.swift
//  Test
//
//  Created by PR on 24/4/2568 BE.
//

import SwiftUI

struct LoginPage: View {
    @Binding var isPresented: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    @State private var isLoggedIn = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            FloatingParticles()
            VStack(spacing: 20) {
                Spacer()
                Text("Login")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Group {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                
                if showError {
                    Text("Invalid username and password")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                
                
                Button("Let's go") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    let savedUSername = UserDefaults.standard.string(forKey: "savedUsername")
                    let savedPassword = UserDefaults.standard.string(forKey: "savedPassword")
                    if (!username.isEmpty && !password.isEmpty) && (username == savedUSername && password == savedPassword) {
                        showError = false
                        isLoggedIn = true
                    } else {
                        showError = true
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.2))
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.horizontal)
                
                Button("Back") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation { isPresented=false }
                }
                .font(.footnote)
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 10)
                Spacer()
            }
            .padding()
            .fullScreenCover(isPresented: $isLoggedIn) {
            }
        }
        
    }
}


#Preview {
    LoginPage(isPresented: .constant(true))
}
