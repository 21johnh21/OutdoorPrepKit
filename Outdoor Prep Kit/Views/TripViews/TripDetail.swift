//
//  TripDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripDetail: View {
    @Binding var trip : Trip
    
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var itemManager = Items()
    @State private var addingNewItem = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text(trip.name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(trip.description).font(.caption)
                }
                .padding()
                Spacer()
            }
            Spacer()
            HStack{
                Text("Items").font(.headline)
                Spacer()
                Button(action: {addingNewItem = true}) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            List{
                ForEach($itemManager.items) { $item in
                    NavigationLink(destination: ItemDetail()){
                        ItemCard(item: item)
                    }
                }
                .onDelete { indexSet in
                    itemManager.items.remove(atOffsets: indexSet)
                }
            }
            .sheet(isPresented: $addingNewItem) {
                ItemEdit(items: $itemManager.items, addingNewItem: $addingNewItem)
            }
            .onDisappear {
                itemManager.save(items: itemManager.items)
                //TODO: Should I also do this when the app is closed?
            }
        }
    }
}


//func getItems(allItems: [Item], tripID: UUID)->[Item]{
//    var itemsForTrip : [Item] = []
//    let tripIDString = tripID.uuidString
//    
//    for item in allItems{
//        for itemTripID in item.tripIDs {
//            if itemTripID == tripIDString {
//                itemsForTrip.append(item)
//            }
//        }
//    }
//    return itemsForTrip
//}

#Preview {
    TripDetail(trip: .constant(Trip.sampleTrips[0]))
}
