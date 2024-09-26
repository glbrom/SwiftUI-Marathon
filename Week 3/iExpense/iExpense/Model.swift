//
//  Model.swift
//  iExpense
//
//  Created by Roman Golub on 26.09.2024.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Codable {
    case business = "Business"
    case personal = "Personal"
}
