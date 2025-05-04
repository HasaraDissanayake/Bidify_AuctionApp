//
//  LoginInterface.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct UserProfileCreation: View {
    @State private var fullName = ""
    @State private var address = ""
    @State private var idNumber = ""
    @State private var mobileNumber = ""
    @State private var email = ""
    @State private var secondaryContact = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false

    private let existingUsernames = ["user123", "john_doe", "alice_smith"] // Simulated usernames

    var isPasswordValid: Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
    }

    var isFormValid: Bool {
        !fullName.isEmpty &&
        !address.isEmpty &&
        !idNumber.isEmpty &&
        !mobileNumber.isEmpty &&
        !username.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        isPasswordValid &&
        !existingUsernames.contains(username)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information").foregroundColor(.teal)) {
                    TextField("Full Name *", text: $fullName)
                    TextField("Address *", text: $address)
                    TextField("ID Number *", text: $idNumber)
                    TextField("Mobile Number *", text: $mobileNumber)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Optional Information").foregroundColor(.teal)) {
                    TextField("Email", text: $email)
                    TextField("Secondary Contact Number", text: $secondaryContact)
                        .keyboardType(.phonePad)
                }

                Section(header: Text("Account Credentials").foregroundColor(.teal)) {
                    TextField("Username *", text: $username)
                    SecureField("Password *", text: $password)
                    SecureField("Confirm Password *", text: $confirmPassword)
                }

                // Password validation message
                if !isPasswordValid && !password.isEmpty {
                    Section {
                        Text("Password must be at least 8 characters and include:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 number\n- 1 special character.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }

                // Username taken warning
                if existingUsernames.contains(username) && !username.isEmpty {
                    Section {
                        Text("Username is already taken. Please choose another.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }

                // Submit button
                Section {
                    Button(action: {
                        if isFormValid {
                            // Placeholder for success logic
                            print("Account successfully created.")
                        } else {
                            showAlert = true
                        }
                    }) {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFormValid ? Color.teal : Color.gray.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                    }
                    .disabled(!isFormValid)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Incomplete or Invalid Form"),
                            message: Text("Please ensure all required fields are filled and valid."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.teal)
        }
    }
}


#Preview {
    UserProfileCreation()
}
