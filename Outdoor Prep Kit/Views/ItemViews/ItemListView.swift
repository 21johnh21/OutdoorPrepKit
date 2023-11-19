//
//  ItemsListView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/19/23.
//

import SwiftUI

struct ItemsListView: View {
    @Binding var items: [Item]
    @Binding var isAddingNewItem: Bool

    var body: some View {
        List {
            ForEach($items) { $item in
                NavigationLink(destination: ItemDetail(item: item)) {
                    ItemCard(item: item)
                }
            }
            .onDelete { indexSet in
                items.remove(atOffsets: indexSet)
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
                    isAddingNewItem = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                }
            }
        }
    }
}

#Preview {
    ItemsListView(items: .constant(Item.sampleItems), isAddingNewItem: .constant(true))
}
