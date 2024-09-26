//
//  ViewModel.swift
//  iExpense
//
//  Created by Roman Golub on 26.09.2024.
//

import SwiftUI

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            saveItemsToUserDefaults()
        }
    }
    
    init() {
        loadItemsFromUserDefaults()
    }
    
    private func saveItemsToUserDefaults() {
        do {
            let encoded = try JSONEncoder().encode(items)
            UserDefaults.standard.set(encoded, forKey: "Items")
        } catch {
            print("Failed to save items to UserDefaults: \(error.localizedDescription)")
        }
    }
    
    private func loadItemsFromUserDefaults() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            do {
                items = try JSONDecoder().decode([ExpenseItem].self, from: savedItems)
            } catch {
                print("Failed to load items from UserDefaults: \(error.localizedDescription)")
            }
        } else {
            items = []
        }
    }
    
    func removeItemsByIds(ids: [UUID]) {
        items.removeAll { ids.contains($0.id) }
    }
}

class ContentViewModel: ObservableObject {
    @Published var expenses = Expenses()
    
    var currencyCode: String {
        if #available(iOS 16, *) {
            return Locale.current.currency?.identifier ?? "USD"
        } else {
            return Locale.current.currencyCode ?? "USD"
        }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == .business }
    }
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == .personal }
    }
    
    func getColorByAmount(_ amount: Double) -> Color {
        switch amount {
        case 0..<10: return .green
        case 10..<100: return .orange
        case 100...: return .red
        default: return .gray
        }
    }
}
