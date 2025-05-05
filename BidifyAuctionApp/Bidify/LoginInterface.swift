//
//  LoginInterface.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct LoginInterface: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()

                VStack(spacing: 8) {
                    Text("Bidify")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.teal)

                    Text("Give value to your precious belongings")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button("Login") {
                    if validateCredentials(username: username, password: password) {
                        showError = false
                        UserDefaults.standard.set(username, forKey: "currentUser")
                        isLoggedIn = true
                    } else {
                        showError = true
                        errorMessage = "Invalid username or password. Please try again."
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.teal)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline)
                .padding(.horizontal)

                NavigationLink(
                    destination: HomeContentView(),
                    isActive: $isLoggedIn,
                    label: { EmptyView() }
                )

                Spacer()

                NavigationLink("Create Account", destination: UserProfileCreation())
                    .font(.subheadline)
                    .padding()
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.teal)
        }
    }

    func validateCredentials(username: String, password: String) -> Bool {
        let usernames = UserDefaults.standard.stringArray(forKey: "Usernames") ?? []
        let storedPassword = KeychainHelper.standard.retrieve(forKey: "password_\(username)") ?? ""
        return usernames.contains(username) && password == storedPassword
    }
}

#Preview {
    LoginInterface()
}
