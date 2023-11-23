//
//  ItemsListView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/19/23.
//

import SwiftUI

struct ItemsListView: View {
    @Binding var items: [Item]
    @Binding var showItemEdit: Bool
    @Binding var editingItem : Item
    
    var body: some View {
        List {
            ForEach($items) { $item in
                NavigationLink(destination: ItemDetail(item: item)) {
                    ItemCard(item: item, showItemEdit: $showItemEdit, editingItem: $editingItem)
                }
            }
            .onDelete { indexSet in
                items.remove(atOffsets: indexSet)
            }
        }
    }
}

#Preview {
    ItemsListView(items: .constant(Item.sampleItems), showItemEdit: .constant(true), editingItem: .constant(Item.sampleItems[0]))
}
