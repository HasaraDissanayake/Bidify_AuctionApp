//
//  BidEntryView.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct BidEntryView: View {
    // These would typically be fetched from a database
    var itemName: String = "Apple iPhone 14"
    var sellerName: String = "Jane Smith"
    var bidderAddress: String = "123 Main St, Cityville"
    var currentHighestBid: Double = 1200.0

    // Bid amount input
    @State private var bidAmount: String = ""

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Place Your Bid")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.teal)

                // Auto-filled info
                Group {
                    InfoRow(label: "Item Name", value: itemName)
                    InfoRow(label: "Seller", value: sellerName)
                    InfoRow(label: "Your Address", value: bidderAddress)
                    InfoRow(label: "Highest Bid", value: "$\(String(format: "%.2f", currentHighestBid))")
                }

                // Bid Input
                VStack(alignment: .leading) {
                    Text("Your Bid Amount")
                        .bold()
                    TextField("Enter amount (USD)", text: $bidAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }

                // Submit Button
                Button(action: {
                    // Handle bid submission here (e.g., send to backend)
                    print("Bid submitted: \(bidAmount)")
                }) {
                    Text("Submit Bid")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Bid Window", displayMode: .inline)
        }
    }
}

struct InfoRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text("\(label):")
                .bold()
            Spacer()
            Text(value)
        }
        .padding(.vertical, 5)
    }
}

struct BidEntryView_Previews: PreviewProvider {
    static var previews: some View {
        BidEntryView()
    }
}
