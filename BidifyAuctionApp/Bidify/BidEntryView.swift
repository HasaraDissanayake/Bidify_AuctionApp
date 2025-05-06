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

enum BidAlertType {
    case success
    case error
}

struct BidEntryView: View {
    let item: AuctionItem
    let bidderAddress: String

    @State private var bidAmount: String = ""
    @State private var highestBid: Double = 0
    @State private var showAlert = false
    @State private var alertType: BidAlertType = .success

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Place Your Bid")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.teal)

            Group {
                InfoRow(label: "Item Name", value: item.name)
                InfoRow(label: "Seller", value: item.seller)
                InfoRow(label: "Your Address", value: bidderAddress)
                InfoRow(label: "Highest Bid", value: "$\(String(format: "%.2f", highestBid))")
            }

            VStack(alignment: .leading) {
                Text("Your Bid Amount")
                    .bold()
                TextField("Enter amount (USD)", text: $bidAmount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }

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
        .onAppear {
            loadHighestBid()
        }
        .alert(isPresented: $showAlert) {
            switch alertType {
            case .success:
                return Alert(
                    title: Text("Bid Submitted"),
                    message: Text("Your bid of $\(bidAmount) was successfully submitted."),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            case .error:
                return Alert(
                    title: Text("Invalid Bid"),
                    message: Text("Please enter a valid amount higher than the current highest bid."),
                    dismissButton: .default(Text("Try Again"))
                )
            }
        }
    }

    func loadHighestBid() {
        let key = "bid_\(item.code)"
        let savedBid = UserDefaults.standard.double(forKey: key)
        highestBid = max(savedBid, item.currentHighestBid)
    }

    func submitBid() {
        guard let bid = Double(bidAmount), bid > highestBid else {
            alertType = .error
            showAlert = true
            return
        }

        let key = "bid_\(item.code)"
        UserDefaults.standard.set(bid, forKey: key)
        highestBid = bid
        alertType = .success
        showAlert = true
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
