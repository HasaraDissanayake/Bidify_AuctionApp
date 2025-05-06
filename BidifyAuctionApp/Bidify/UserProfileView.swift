//
//  UserProfileView.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct UserProfileView: View {
    private var currentUser: String? {
        UserDefaults.standard.string(forKey: "currentUser")
    }

    private var profile: [String: String]? {
        guard let username = currentUser else { return nil }
        return UserDefaults.standard.dictionary(forKey: "user_\(username)") as? [String: String]
    }

    private var fullName: String {
        profile?["fullName"] ?? "Not Available"
    }

    private var address: String {
        profile?["address"] ?? "Not Available"
    }

    private var idNumber: String {
        profile?["idNumber"] ?? "Not Available"
    }

    private var mobileNumber: String {
        profile?["mobileNumber"] ?? "Not Available"
    }

    private var email: String {
        profile?["email"] ?? "Not Available"
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let username = currentUser {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 20) {
                                Text("Profile")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.teal)
                                    .padding(.top)

                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.black)

                                Text(username)
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.teal)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)

                                Button(action: {
                                    withAnimation {
                                        proxy.scrollTo("detailsSection", anchor: .top)
                                    }
                                }) {
                                    HStack(spacing: 5) {
                                        Image(systemName: "arrow.down.circle.fill")
                                            .font(.title2)
                                        Text("Scroll to Details")
                                            .font(.subheadline)
                                            .bold()
                                    }
                                    .foregroundColor(.teal)
                                }

                                VStack(spacing: 10) {
                                    DetailBox(label: "Full Name", value: fullName)
                                    DetailBox(label: "NIC Number", value: idNumber)
                                    DetailBox(label: "Phone Number", value: mobileNumber)
                                    DetailBox(label: "Email", value: email)
                                    DetailBox(label: "Address", value: address)
                                }
                                .id("detailsSection")

                                VStack(alignment: .center, spacing: 10) {
                                    Text("Help Center")
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)

                                    Text("Email: bidfysupport@gmail.com")
                                        .font(.title3)
                                        .foregroundColor(.white)

                                    Text("Tel: +94 11 254 254")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.0, green: 0.2, blue: 0.2))
                                .cornerRadius(10)
                            }
                            .padding()
                            .padding(.bottom, 80)
                        }
                    }

                    

                } else {
                    Text("No user is currently logged in.")
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct DetailBox: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .bold()
            Spacer()
            Text(value)
        }
        .padding()
        .background(Color.teal.opacity(0.1))
        .cornerRadius(6)
    }
}



struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
