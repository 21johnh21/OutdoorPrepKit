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
    @State private var showItemEdit = false
    @State private var isAddingNewItem = false
    @State private var isCopyingTrip = false
    @ObservedObject private var itemManager: Items
    init(trip: Binding<Trip>) {
            self._trip = trip
            self._itemManager = ObservedObject(wrappedValue: Items(tripID: trip.id))
    }
    
    @State private var editingItem = Item(name: "", brand: "", model: "", weight: 0.0, qty: 1, category: "Shelter", tripIDs: [])

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
                    showItemEdit = true
                    isAddingNewItem = true}) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            ItemsListView(items: $itemManager.items, showItemEdit: $showItemEdit, editingItem: $editingItem)
            .sheet(isPresented: $showItemEdit) {
                ItemEdit(items: $itemManager.items, showItemEdit: $showItemEdit, addingNewItem: $isAddingNewItem, tripID: trip.id, item: $editingItem)
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
