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
    @State private var isCopyingTrip = false
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
            ItemsListView(items: $itemManager.items, isAddingNewItem: $isAddingNewItem)
            .sheet(isPresented: $isAddingNewItem) {
                ItemEdit(items: $itemManager.items, addingNewItem: $isAddingNewItem, tripID: trip.id)
            }
            .onDisappear {
                itemManager.save(items: itemManager.items)
                //TODO: Should I also do this when the app is closed?
            }
        }
        .toolbar {
            Button(action: { isCopyingTrip = true }) {
                Image(systemName: "doc.on.doc.fill")
            }
        }
        .sheet(isPresented: $isCopyingTrip) {
            //TripEdit(trips: $trips, addingNewTrip: $isCopyingTrip)
        }
    }
}

#Preview {
    TripDetail(trip: .constant(Trip.sampleTrips[0]))
}
