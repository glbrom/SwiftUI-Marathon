//
//  MainView.swift
//  iExpense
//
//  Created by Roman Golub on 26.09.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                if !viewModel.businessExpenses.isEmpty {
                    displayExpenseListByType(
                        title: "Business",
                        expenses: viewModel.businessExpenses
                    )
                }
                
                if !viewModel.personalExpenses.isEmpty {
                    displayExpenseListByType(
                        title: "Personal",
                        expenses: viewModel.personalExpenses
                    )
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: viewModel.expenses, currencyCode: viewModel.currencyCode)
            }
        }
    }
    
    func displayExpenseListByType(title: String, expenses: [ExpenseItem]) -> some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type.rawValue)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: viewModel.currencyCode))
                        .foregroundColor(viewModel.getColorByAmount(item.amount))
                }
            }
            .onDelete { indexSet in
                viewModel.expenses.items.remove(atOffsets: indexSet)
            }
        }
    }
}

#Preview {
    MainView()
}
