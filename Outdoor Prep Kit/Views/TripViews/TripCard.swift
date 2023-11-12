//
//  TripCard.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import SwiftUI

struct TripCard: View {
    @Binding var trip : Trip
    
    var body: some View {
        VStack(alignment: .leading){
            Text(trip.name)
            Text(trip.description)
        }
    }
}

#Preview {
    TripCard(trip: .constant(Trip.sampleTrips[0]))
}
