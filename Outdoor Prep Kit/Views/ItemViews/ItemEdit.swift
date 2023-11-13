//
//  ItemEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct ItemEdit: View {
    @Binding var items: [Item]
    @Binding var addingNewItem: Bool
    
    @State private var item = Item.emptyItem
    
    var body: some View {
        NavigationStack {
            Form{
                HStack {
                    VStack(alignment: .leading){
                        TextField("Item Name", text: $item.name)
                        TextField("Brand", text: $item.brand)
                        TextField("Model", text: $item.model)
                        HStack{
                            //TextField("weight", text: $item.weight)
                            Spacer()
                            //TextField("qty", text: $item.qty)
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
