//
//  ItemEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI
import Combine

struct ItemEdit: View {
    @Binding var items: [Item]
    @Binding var addingNewItem: Bool
    let tripID : UUID
    @Binding var item : Item
    
    @State private var tempWeight : String = ""
    let categories = Item.categories
   
    var body: some View {
        NavigationStack {
            Form{
                HStack {
                    VStack(alignment: .leading){
                        TextField("Item Name", text: $item.name)
                        TextField("Brand", text: $item.brand)
                        TextField("Model", text: $item.model)
                        HStack{
                            TextField("weight", text: $tempWeight)
                                .keyboardType(.numberPad)
                                .onReceive(Just(tempWeight)) { newValue in
                                    tempWeight = newValue.filter { $0.isNumber || $0 == "." }
                                    item.weight = Double(tempWeight) ?? 0
                                }
                            Spacer()
                            Text("oz.").foregroundColor(.gray)
                        }
                        HStack{
                            Stepper("Qty", value: $item.qty, in: 1...100)
                            Spacer()
                            Text(String(item.qty))
                        }
                        Picker("Category", selection: $item.category) {
                            ForEach(categories, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                    Spacer()
                }
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Dismiss"){
                        addingNewItem = false
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    if addingNewItem {
                        Button(addingNewItem ? "Add" : "Save"){
                            items.append(item)
                            addingNewItem = false
                        }
                    }else{
                        Button(addingNewItem ? "Add" : "Save"){
                            items.append(item)
                            addingNewItem = false
                        }
                    }
                }
            }
            .onAppear {
                item.tripIDs.append(tripID)
            }
            .onDisappear{
                print("disapear")
                addingNewItem = false
            }
        }
    }
}

#Preview {
    ItemEdit(items: .constant(Item.sampleItems), addingNewItem: .constant(true), tripID: UUID(), item: .constant(Item.sampleItems[0]))
}
