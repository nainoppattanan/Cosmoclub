//
//  RegisterPage.swift
//  Cosmoclub
//
//  Created by Admin on 26/4/2568 BE.
//

import SwiftUI

struct RegisterPage: View {
    @Binding var currentPage: Int
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToLogin = false
    @State private var message = ""
    @State private var messageColor: Color = .clear
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                Text("Create your account")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                Group {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                
                if !message.isEmpty {
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(messageColor)
                }
                
                Button("Sign in") {
                    if !username.isEmpty && !password.isEmpty {
                        UserDefaults.standard.set(username, forKey: "savedUsername")
                        UserDefaults.standard.set(password, forKey: "savedPassword")
                        message = "Account created successfully!"
                        messageColor = .green
                        username = ""
                        password = ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            message = ""
                        }
                    } else {
                        message = "Please enter both username and password"
                        messageColor = .red

                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.2))
                .cornerRadius(12)
                .foregroundColor(.white)
                .padding(.horizontal)
                
                Button("Already have an account? Login.") {
                    withAnimation { navigateToLogin=true }
                }
                .font(.footnote)
                .foregroundStyle(.white)
                .padding(.top, 10)
                Spacer()
        }
        .padding()
        if navigateToLogin {
            LoginPage(isPresented: $navigateToLogin)
                .transition(.opacity)
                .zIndex(1)
            }
        }
        .animation(.easeInOut, value: navigateToLogin)

    }
}

#Preview {
    RegisterPage(currentPage: .constant(2))
}
