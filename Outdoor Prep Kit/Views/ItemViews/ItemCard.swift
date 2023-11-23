//
//  ItemCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct ItemCard: View {
    let item: Item
    @Binding var showItemEdit : Bool
    @Binding var editingItem : Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(item.name).font(.title3)
                HStack{
                    Text(item.brand + " " + item.model).font(.caption)
                }
                HStack{
                    Text(String(item.weight)+"  oz.").font(.caption)
                    Spacer()
                    Text(String(item.qty)).font(.caption)
                }
            }
            .padding()
            Spacer()
            Image(systemName: "backpack.circle")
                .font(.system(size: 64))
                .padding(.trailing)
                .foregroundColor(.green)
            //TODO: programatically change color based on packed status
        }
        .swipeActions(edge: .leading) {
            Button(action: {
                print("Pack")
            }) {
                Image(systemName: "backpack.circle.fill")
                // TODO: Make this so swiping all the way to the right packs the item
            }
            Button(action: {
                print("Edit")
                editingItem = item
                showItemEdit = true
            }) {
                Image(systemName: "pencil.circle.fill")
            }
        }
    }
}

//#Preview {
//    ItemCard(item: Item.sampleItems[0])
//}
