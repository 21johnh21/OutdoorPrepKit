//
//  ItemStore.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/12/23.
//

import Foundation

class ItemStore: ObservableObject{
    @Published var items: [Item] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("items.data")
    }
    
    func load() async throws {
        let task = Task<[Item], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            // for debuging -------
            if let json = String(data: data, encoding: .utf8) {
                print(json)
            }
            // ----
            let items = try JSONDecoder().decode([Item].self, from: data)
            //TODO: filter down to only the items we want here
            return items
        }
        let items = try await task.value
        self.items = items
    }
    
    func save(items: [Item]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(items)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

