//
//  UserProfileCreation.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI
import Security

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
    @State private var showSuccessAlert = false

    var existingUsernames: [String] {
        UserDefaults.standard.stringArray(forKey: "Usernames") ?? []
    }

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
                        .textContentType(.newPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    SecureField("Confirm Password *", text: $confirmPassword)
                        .textContentType(.newPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }

                if !isPasswordValid && !password.isEmpty {
                    Section {
                        Text("Password must be at least 8 characters and include:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 number\n- 1 special character.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }

                if existingUsernames.contains(username) && !username.isEmpty {
                    Section {
                        Text("Username is already taken. Please choose another.")
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                }

                Section {
                    Button("Create Account") {
                        if isFormValid {
                            saveUserData()
                            showSuccessAlert = true
                            clearForm()
                        } else {
                            showAlert = true
                        }
                    }
                    .disabled(!isFormValid)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.teal : Color.gray.opacity(0.4))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Create Account")
            .alert("Incomplete or Invalid Form", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please ensure all required fields are filled and valid.")
            }
            .alert("Account Created", isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Your account has been successfully created.")
            }
        }
    }

    func saveUserData() {
        let profile: [String: String] = [
            "fullName": fullName,
            "address": address,
            "idNumber": idNumber,
            "mobileNumber": mobileNumber,
            "email": email,
            "secondaryContact": secondaryContact
        ]
        UserDefaults.standard.set(profile, forKey: "user_\(username)")
        KeychainHelper.standard.save(password, forKey: "password_\(username)")

        var usernames = UserDefaults.standard.stringArray(forKey: "Usernames") ?? []
        usernames.append(username)
        UserDefaults.standard.set(usernames, forKey: "Usernames")
    }

    func clearForm() {
        fullName = ""
        address = ""
        idNumber = ""
        mobileNumber = ""
        email = ""
        secondaryContact = ""
        username = ""
        password = ""
        confirmPassword = ""
    }
}

#Preview {
    UserProfileCreation()
}

// MARK: - Keychain Helper
class KeychainHelper {
    static let standard = KeychainHelper()

    func save(_ value: String, forKey key: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func retrieve(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?

        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            if let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
}

