//
//  TripEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripEdit: View {
    @Binding var trips: [Trip]
    @Binding var addingNewTrip: Bool
    
    @State private var trip = Trip(name: "", description:"")
    
    var body: some View {
        NavigationStack {
            Form{
                TextField("Trip Name", text: $trip.name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Trip Description", text: $trip.description)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Dismiss"){
                        addingNewTrip = false
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Add"){
                        trips.append(trip)
                        addingNewTrip = false
                    }
                }
            }
        }
    }
}

#Preview {
    TripEdit(trips: .constant(Trip.sampleTrips), addingNewTrip: .constant(true))
}
