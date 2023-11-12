//
//  TripDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripDetail: View {
    @Binding var trip : Trip 
    
    @EnvironmentObject var itemStore: ItemStore
//    @Environment(\.scenePhase) private var scenePhase
//    let saveAction: ()->Void
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
            NavigationStack{
                List(getItems(allItems: itemStore, tripID: trip.id)){ item in
                    
                }
            }
//            .sheet(isPresented: $addingNewItem){
//                ItemEdit(items: $itemStore, addingNewItem: $addingNewItem)
//            }
//            .onChange(of: scenePhase) {
//                if scenePhase == .inactive {
//                    saveAction()
//                }
//            }
        }
    }
}

func getItems(allItems: ItemStore, tripID: UUID)->[Item]{
    var itemsForTrip : [Item] = []
    let tripIDString = tripID.uuidString
    
    for item in allItems.items{
        for itemTripID in item.tripIDs {
            if itemTripID == tripIDString {
                itemsForTrip.append(item)
            }
        }
    }
    return itemsForTrip
}

#Preview {
    TripDetail(trip: .constant(Trip.sampleTrips[0])).environmentObject(ItemStore())
}
