//
//  TripsView.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripsView: View {
    
    @ObservedObject private var tripsManager = Trips()
    @State private var showTripEdit = false
    @State private var editingTrip = Trip(name: "", description: "")
    @State private var isAddingTrip = false
    @Environment(\.scenePhase) private var scenePhase
    
    //TODO: Add a way to identify the most recently edited trip and display them in order. 

    var body: some View {
        Text("Outdoor Prep Kit").font(.title)
        NavigationView {
            List {
                ForEach($tripsManager.trips) { $trip in
                    NavigationLink(destination: TripDetail(trip: $trip)) {
                        TripCard(trip: $trip, showTripEdit: $showTripEdit, editingTrip: $editingTrip)
                    }
                }
                .onDelete { indexSet in
                    tripsManager.trips.remove(atOffsets: indexSet)
                }
            }
            .toolbar {
                Button(action: { 
                    showTripEdit = true
                    isAddingTrip = true}) {
                    Image(systemName: "plus")
                }
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                tripsManager.save(trips: tripsManager.trips)
            }
        }
        .sheet(isPresented: $showTripEdit) {
            TripEdit(trips: $tripsManager.trips, showTripEdit: $showTripEdit, trip: $editingTrip, isAddingTrip: $isAddingTrip)
        }
    }
}

#Preview {
    TripsView()
}
