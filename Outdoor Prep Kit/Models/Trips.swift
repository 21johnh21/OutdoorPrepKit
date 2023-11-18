//
//  Trips.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/18/23.
//

import Foundation

class Trips: ObservableObject{
    
    @Published var trips = [Trip]()
    
    init(){
        load()
    }
    
    func save (trips: [Trip]){
        let data = try? JSONEncoder().encode(trips)
        guard let outfile = try? Self.getFileURL() else { return }
        try? data?.write(to: outfile)
    }
    
    func load (){
        guard let fileURL = try? Self.getFileURL() else { return }
        guard let data = try? Data(contentsOf: fileURL) else { return }
        // for debuging -------
        if false{
            if let json = String(data: data, encoding: .utf8) {
                print(json)
            }
        }
        // ----
        let trips = try? JSONDecoder().decode([Trip].self, from: data)
        self.trips = trips ?? []
    }
    
    private static func getFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("trips.data")
    }

}

