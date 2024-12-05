//
//  Card.swift
//  WalletCardAnimation
//
//  Created by Daniel Martinez Condinanza on 5/12/24.
//

import SwiftUI

struct Card: Identifiable {
    
    let id: String = UUID().uuidString
    var number: String
    var expires: String
    var color: Color
    
    var visaGeomtryId: String {
        "VISACARD_\(id)"
    }
}

let cards: [Card] = [
    Card(number: "**** **** **** 3456", expires: "12/24", color: .blue),
    Card(number: "**** **** **** 7654", expires: "11/25", color: .indigo),
    Card(number: "**** **** **** 8901", expires: "08/23", color: .black),
    Card(number: "**** **** **** 6543", expires: "05/26", color: .pink)
]
