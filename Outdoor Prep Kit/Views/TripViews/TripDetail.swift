//
//  TripDetail.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripDetail: View {
    @Binding var trip : Trip 
    @Binding var items : [Item]
    
//    @EnvironmentObject var itemStore: ItemStore
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
//    @StateObject private var itemStore = ItemStore()
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
//                List(getItems(allItems: items, tripID: trip.id)){ item in
//                    ItemCard(item: item)
//                }
                List(items){ item in
                    ItemCard(item: item)
                }
            }
            .sheet(isPresented: $addingNewItem){
                ItemEdit(items: $items, addingNewItem: $addingNewItem)
            }
            .onChange(of: scenePhase) {
                //TODO: I need to use something other than scene phase here. This only saves when the app is closed.
                if scenePhase == .inactive || scenePhase == .background {
                    saveAction()
                }
            }
        }
    }
}

func getItems(allItems: [Item], tripID: UUID)->[Item]{
    var itemsForTrip : [Item] = []
    let tripIDString = tripID.uuidString
    
    for item in allItems{
        for itemTripID in item.tripIDs {
            if itemTripID == tripIDString {
                itemsForTrip.append(item)
            }
        }
    }
    return itemsForTrip
}

//#Preview {
//    //TripDetail(trip: .constant(Trip.sampleTrips[0]), items: )
//}
