//
//  Items.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/18/23.
//

import Foundation

class Items: ObservableObject{
    
    @Published var items = [Item]()
    
    init(){
        load()
    }
    
    func save (items: [Item]){
        let data = try? JSONEncoder().encode(items)
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
        let items = try? JSONDecoder().decode([Item].self, from: data)
        self.items = items ?? []
    }
    
    private static func getFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("items.data")
    }

}
