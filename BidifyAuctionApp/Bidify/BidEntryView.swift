//
//  BidEntryView.swift
//  Bidify
//
//  Created by Naween Weerasinghe on 2025-05-01.
//

import SwiftUI

struct AuctionItem {
    var code: String
    var name: String
    var seller: String
    var currentHighestBid: Double
}

struct BidEntryView: View {
    let item: AuctionItem
    let bidderAddress: String

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
                    InfoRow(label: "Item Name", value: item.name)
                    InfoRow(label: "Seller", value: item.seller)
                    InfoRow(label: "Your Address", value: bidderAddress)
                    InfoRow(label: "Highest Bid", value: "$\(String(format: "%.2f", item.currentHighestBid))")
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
                    submitBid()
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

    // Save the bid with item code
    func submitBid() {
        guard let bid = Double(bidAmount), bid > item.currentHighestBid else {
            print("Bid is too low or invalid.")
            return
        }

        // Save to UserDefaults as a simple built-in storage method
        let key = "bid_\(item.code)"
        UserDefaults.standard.set(bid, forKey: key)

        print("Bid of \(bid) saved for item code \(item.code)")
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
        let sampleItem = AuctionItem(
            code: "A123",
            name: "Apple iPhone 14",
            seller: "Jane Smith",
            currentHighestBid: 1200.0
        )
        BidEntryView(item: sampleItem, bidderAddress: "123 Main St, Cityville")
    }
}
