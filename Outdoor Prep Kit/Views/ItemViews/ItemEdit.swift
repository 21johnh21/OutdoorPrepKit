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
    
    @State private var item = Item(name: "", brand: "", model: "", weight: 0.0, qty: 1, category: "", tripIDs: [])
    //TODO: ^ probably give this id of the trip it's called from
    @State private var tempWeight : String = ""
    let digitSet = CharacterSet.decimalDigits
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
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
                    Button("Add"){
                        items.append(item)
                        addingNewItem = false
                    }
                }
            }
        }
    }
}

#Preview {
    ItemEdit(items: .constant(Item.sampleItems), addingNewItem: .constant(true))
}
