//
//  Outdoor_Prep_KitApp.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/11/23.
//

import SwiftUI

@main
struct Outdoor_Prep_KitApp: App {
    @StateObject private var tripStore = TripStore()
    //@StateObject private var itemStore = ItemStore()
    
    var body: some Scene {
        WindowGroup {
            TripsView(trips: $tripStore.trips){
                Task {
                    do {
                        try await tripStore.save(trips: tripStore.trips)
                    } catch {
                        fatalError() //TODO: handle
                    }
                }
            }
            .task {
                do {
                    try await tripStore.load()
                } catch {
                    fatalError() //TODO: handle
                }
            }
//            .task {
//                do {
//                    try await itemStore.load()
//                } catch {
//                    fatalError() //TODO: handle
//                }
//            }
            //.environmentObject(itemStore)
        }
    }
}
