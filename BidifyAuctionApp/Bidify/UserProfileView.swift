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
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Profile Title
                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.teal)
                        
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
                        
                        // User Details
                        VStack(spacing: 10) {
                            DetailBox(label: "Full Name", value: "John Doe")
                            DetailBox(label: "NIC Number", value: "123456789V") // ✅ Added NIC Number
                            DetailBox(label: "Phone Number", value: "+1 123-456-7890")
                            DetailBox(label: "Email", value: "johndoe@example.com")
                            DetailBox(label: "Address", value: "123 Main St, Cityville")
                        }
                        .padding(.bottom, 100) // Space for help center
                    }
                    .padding()
                }
                
                // Help Center - fixed at the bottom
                VStack(alignment: .center, spacing: 10) {
                    Text("Help Center")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center) // Center the title
                    Text("Email: bidfysupport@gmail.com")
                        .font(.title3)
                        .foregroundColor(.white)
                    Text("Tel: +94 11 254 254")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.0, green: 0.2, blue: 0.2)) // Darker teal
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .navigationBarTitleDisplayMode(.inline) // Keeps title inline
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
        .background(Color.teal.opacity(0.1)) // light teal box
        .cornerRadius(6)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
