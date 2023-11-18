//
//  ItemDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct ItemDetail: View {
    let item : Item
    
    var body: some View {
        Text(item.name).font(.title).padding(.top)
        HStack {
            VStack(alignment: .leading){
                Text(item.brand)
                Text(item.model)
                Text(String(item.weight))
                Text(String(item.qty))
            }
            .padding()
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    ItemDetail(item: Item.sampleItems[0])
}
