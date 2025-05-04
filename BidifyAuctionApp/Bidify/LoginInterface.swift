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

                // App Logo/Title
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

                // Input Fields
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

                // Error Message
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                // Login Button
                Button(action: {
                    if validateCredentials(username: username, password: password) {
                        showError = false
                        // Capture current user
                        UserDefaults.standard.set(username, forKey: "currentUser")
                        print("✅ Login successful for user: \(username)")
                        isLoggedIn = true
                        // Navigate to UserProfileView after successful login
                    } else {
                        showError = true
                        errorMessage = "Invalid username or password. Please try again."
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.headline)
                }
                .padding(.horizontal)

                Spacer()

                // Navigate to Create Account page
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

    // Validate the entered credentials against stored data in UserDefaults
    func validateCredentials(username: String, password: String) -> Bool {
        // Retrieve the saved username and password from UserDefaults
        let storedUsername = UserDefaults.standard.string(forKey: "username_\(username)") ?? ""
        let storedPassword = KeychainHelper.standard.retrieve(forKey: "password_\(username)") ?? ""

        return username == storedUsername && password == storedPassword
    }
}

struct LoginInterface_Previews: PreviewProvider {
    static var previews: some View {
        LoginInterface()
    }
}
