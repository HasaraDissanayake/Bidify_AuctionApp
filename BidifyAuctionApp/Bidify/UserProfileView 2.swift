//
//  UserProfileCreation.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            // Profile Title
                            Text("Profile")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.teal)
                                .padding(.top)

                            // Profile Photo
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.black)

                            // Username Box
                            Text("johndoe123")
                                .font(.headline)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.teal)
                                .foregroundColor(.white)
                                .cornerRadius(8)

                            // Scroll Down Button
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

                            // User Details
                            VStack(spacing: 10) {
                                DetailBox(label: "Full Name", value: "John Doe")
                                DetailBox(label: "NIC Number", value: "123456789V")
                                DetailBox(label: "Phone Number", value: "+1 123-456-7890")
                                DetailBox(label: "Email", value: "johndoe@example.com")
                                DetailBox(label: "Address", value: "123 Main St, Cityville")
                            }
                            .id("detailsSection")

                            // Help Center
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
                        .padding(.bottom, 80) // Space for footer
                    }
                }

                // Footer Section (fixed)
                HStack {
                    FooterButton(icon: "house.fill", label: "Home")
                    Spacer()
                    FooterButton(icon: "chart.bar.fill", label: "Dashboard")
                    Spacer()
                    FooterButton(icon: "heart.fill", label: "Wishlist")
                    Spacer()
                    FooterButton(icon: "checkmark.circle.fill", label: "Completed")
                    Spacer()
                    FooterButton(icon: "gearshape.fill", label: "Settings")
                }
                .padding()
                .background(Color(.systemGray6))
                .foregroundColor(.teal)
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

struct FooterButton: View {
    var icon: String
    var label: String

    var body: some View {
        Button(action: {
            // Navigation placeholder
        }) {
            VStack {
                Image(systemName: icon)
                Text(label)
                    .font(.footnote)
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
