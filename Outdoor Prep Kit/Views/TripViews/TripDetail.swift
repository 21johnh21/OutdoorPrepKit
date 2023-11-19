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
    @State private var isAddingNewItem = false
    @ObservedObject private var itemManager: Items
    init(trip: Binding<Trip>) {
            self._trip = trip
            self._itemManager = ObservedObject(wrappedValue: Items(tripID: trip.id))
    }

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
                Button(action: {
                    isAddingNewItem = true}) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            List{
                ForEach($itemManager.items) { $item in
                    NavigationLink(destination: ItemDetail(item: item)){
                        ItemCard(item: item)
                    }
                }
                .onDelete { indexSet in
                    itemManager.items.remove(atOffsets: indexSet)
                }
                .swipeActions(edge: .leading){
                    Button(action: {
                        print("Pack")}) {
                        Image(systemName: "backpack.circle.fill")
                        //TODO: Make this so swipping all the way to the right packs the item
                    }
                    Button(action: {
                        print("Edit")
                        isAddingNewItem = true }) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewItem) {
                ItemEdit(items: $itemManager.items, addingNewItem: $isAddingNewItem, tripID: trip.id)
            }
            .onDisappear {
                itemManager.save(items: itemManager.items)
                //TODO: Should I also do this when the app is closed?
            }
        }
    }
}

#Preview {
    TripDetail(trip: .constant(Trip.sampleTrips[0]))
}
