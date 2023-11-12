//
//  TripStore.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import Foundation

@MainActor
class TripStore: ObservableObject {
    @Published var trips: [Trip] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("trips.data")
    }
    
    func load() async throws {
        let task = Task<[Trip], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            // for debuging -------
//            if let json = String(data: data, encoding: .utf8) {
//                print(json)
//            }
            // ----
            let trips = try JSONDecoder().decode([Trip].self, from: data)
            return trips
        }
        let trips = try await task.value
        self.trips = trips
    }
    
    func save(trips: [Trip]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(trips)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
