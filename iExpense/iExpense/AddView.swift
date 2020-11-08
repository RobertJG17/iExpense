//
//  SwiftUIView.swift
//  iExpense
//
//  Created by Robert Guerra on 11/5/20.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var showingAlert = false
    @State var amount: String = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Float(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
            })
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Invalid Input"), message: Text("Please enter a proper value."), dismissButton: .default(Text("OK")))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
