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
    @Binding var editingItem : Item
    
    var body: some View {
        List {
            ForEach($items) { $item in
                NavigationLink(destination: ItemDetail(item: item)) {
                    ItemCard(item: item, isEditingItem: $isAddingNewItem, editingItem: $editingItem)
                }
            }
            .onDelete { indexSet in
                items.remove(atOffsets: indexSet)
            }
        }
    }
}

#Preview {
    ItemsListView(items: .constant(Item.sampleItems), isAddingNewItem: .constant(true), editingItem: .constant(Item.sampleItems[0]))
}
