//
//  Trip.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import Foundation

struct Trip: Identifiable, Codable {
    let id : UUID
    var name : String
    var description : String
    
    init(id: UUID=UUID(), name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

extension Trip {
    static let emptyTrip : Trip =
    Trip(name: "", description: "")
}

extension Trip {
    static let sampleTrips: [Trip] =
    [
        Trip(
            name: "Hiking",
            description: "day hike with no over nigth supplies"
        ),
        Trip(
            name: "Backpacking",
            description: "Multi day hik"
        ),
        Trip(
            name: "Bushcrafting",
            description: "Multi day hike with an emphasis on living off the land"
        )
    ]
}

