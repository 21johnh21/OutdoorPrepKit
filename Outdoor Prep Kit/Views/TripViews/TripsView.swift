//
//  TripsView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripsView: View {
    
    @ObservedObject private var tripsManager = Trips()
    @State private var addingNewTrip = false
    @Environment(\.scenePhase) private var scenePhase
    
    //TODO: Add a way to identify the most recently edited trip and display them in order. 

    var body: some View {
        Text("Outdoor Prep Kit").font(.title)
        NavigationView {
            List {
                ForEach($tripsManager.trips) { $trip in
                    NavigationLink(destination: TripDetail(trip: $trip)) {
                        TripCard(trip: $trip)
                    }
                }
                .onDelete { indexSet in
                    tripsManager.trips.remove(atOffsets: indexSet)
                }
                .swipeActions(edge: .leading) {
                    Button(action: {
                        //TODO: Add Action 
                    }) {
                        Image(systemName: "pencil.circle.fill")
                    }
                }
            }
            .toolbar {
                Button(action: { addingNewTrip = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                tripsManager.save(trips: tripsManager.trips)
            }
        }
        .sheet(isPresented: $addingNewTrip) {
            TripEdit(trips: $tripsManager.trips, addingNewTrip: $addingNewTrip)
        }
    }
}

#Preview {
    TripsView()
}
