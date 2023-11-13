//
//  TripsView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripsView: View {
    @Binding var trips: [Trip]
    
    @State private var addingNewTrip = false
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var itemStore = ItemStore()
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack{
            List($trips) { $trip in
                NavigationLink(destination: TripDetail(trip: $trip, items: $itemStore.items){
                    Task {
                        do {
                            try await itemStore.save(items: itemStore.items)
                        } catch {
                            fatalError() //TODO: handle
                        }
                    }
                }
                .task {
                    do {
                        try await itemStore.load()
                    } catch {
                        fatalError() //TODO: handle
                    }
                })
                { TripCard(trip: $trip)}
            }
            .toolbar{
                Button(action: {addingNewTrip = true}) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $addingNewTrip){
            TripEdit(trips: $trips, addingNewTrip: $addingNewTrip)
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                saveAction()
            }
        }
    }
}

#Preview {
    TripsView(trips: .constant(Trip.sampleTrips), saveAction: {})
}
