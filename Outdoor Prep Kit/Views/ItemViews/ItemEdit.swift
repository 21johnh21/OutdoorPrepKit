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
        Form{
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
            }
        }
    }
}

#Preview {
    ItemEdit(items: .constant(Item.sampleItems), addingNewItem: .constant(true))
}
