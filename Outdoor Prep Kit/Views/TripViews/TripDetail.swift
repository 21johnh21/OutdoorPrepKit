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
    @GestureState private var isDetectingLongPress = false
    @State private var isAddingNewItem = false
    @State private var isAddingOrEditingItem = false
    
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
                    isAddingNewItem = true
                    isAddingOrEditingItem = true }) {
                    Image(systemName: "plus")
                }
            }
            .padding()
            List{
                ForEach($itemManager.items) { $item in
                    NavigationLink(destination: ItemDetail(item: item)){
                        ItemCard(item: item)
                            .gesture(
                                LongPressGesture(minimumDuration: 1)
                                .updating($isDetectingLongPress) { currentState, gestureState,
                                        transaction in
                                    gestureState = currentState
                                    transaction.animation = Animation.easeIn(duration: 2.0)
                                }
                            )
                    }
                }
                .onDelete { indexSet in
                    itemManager.items.remove(atOffsets: indexSet)
                }
            }
            .onChange(of: isDetectingLongPress) {
                if isDetectingLongPress {
                    print("long press")
                    isAddingOrEditingItem = true
                }
            }
            .sheet(isPresented: $isAddingOrEditingItem) {
                ItemEdit(items: $itemManager.items, isAddingOrEditingItem: $isAddingOrEditingItem, addingNewItem: $isAddingNewItem)
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
