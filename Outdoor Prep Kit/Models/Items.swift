//
//  Items.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/18/23.
//

import Foundation

class Items: ObservableObject {
    var tripID: UUID?

    @Published var items = [Item]()

    init(tripID: UUID?) {
        self.tripID = tripID
        load()
    }

    func save(items: [Item]) {
        let data = try? JSONEncoder().encode(items)
        guard let outfile = try? Self.getFileURL(tripID: tripID) else { return }
        try? data?.write(to: outfile)
    }

    func load() {
        guard let fileURL = try? Self.getFileURL(tripID: tripID) else { return }
        guard let data = try? Data(contentsOf: fileURL) else { return }

        if let tripID = tripID {
            let itemsForTrip = (try? JSONDecoder().decode([Item].self, from: data))?
                .filter { $0.tripIDs.contains(tripID) } ?? []
            self.items = itemsForTrip
        } else {
            let allItems = try? JSONDecoder().decode([Item].self, from: data)
            self.items = allItems ?? []
        }
    }

    private static func getFileURL(tripID: UUID?) throws -> URL {
        var fileName = "items.data"
        if let tripID = tripID {
            fileName = "items_\(tripID.uuidString).data"
        }
        return try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
            .appendingPathComponent(fileName)
    }
}
