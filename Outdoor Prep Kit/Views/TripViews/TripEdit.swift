//
//  TripEdit.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripEdit: View {
    @Binding var trips: [Trip]
    @Binding var showTripEdit: Bool
    @Binding var trip : Trip
    @Binding var isAddingTrip : Bool
    
    
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
                        showTripEdit = false
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    if isAddingTrip {
                        Button("Add"){
                            trips.append(trip)
                            isAddingTrip = false
                            showTripEdit = false
                        }
                    } else {
                        Button("Save"){
                            if let index = trips.firstIndex(where: { $0.id == trip.id }) {
                                trips[index] = trip
                            }
                            showTripEdit = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TripEdit(trips: .constant(Trip.sampleTrips), showTripEdit: .constant(true), trip: .constant(Trip.sampleTrips[0]), isAddingTrip: .constant(false))
}
