//
//  Item.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 11/11/23.
//

import Foundation

struct Item: Identifiable, Codable {
    let id : UUID
    let name : String
    let brand : String
    let model : String
    let weight : Double
    let qty : Int
    let category : String
    let tripIDs : [String]
    
    init(id: UUID=UUID(), name: String, brand: String, model: String, weight: Double, qty: Int, category: String, tripIDs: [String]) {
        self.id = id
        self.name = name
        self.brand = brand
        self.model = model
        self.weight = weight
        self.qty = qty
        self.category = category
        self.tripIDs = tripIDs
    }
}

extension Item{
    static let emptyItem : Item =
    Item(name: "", brand: "", model: "", weight: 0, qty: 0, category: "", tripIDs: [])
}

extension Item{
    static var sampleItems : [Item] =
    [
        Item(
            name: "Tent",
            brand: "Big Agnes",
            model: "Copper Spur",
            weight: 20.2,
            qty: 1,
            category: "Shelter",
            tripIDs: ["25355B5F-1111-4E5E-9EC1-5F7F321F09CB","8028A058-B662-45A8-A1B2-52F94F314911","8028A058-B662-45A8-A1B2-52F94F314911"]
        ),
        Item(
            name: "Sleeping Bag",
            brand: "Big Agnes",
            model: "Sub Zero Bag",
            weight: 40.5,
            qty: 1,
            category: "Sleep",
            tripIDs: ["25355B5F-1111-4E5E-9EC1-5F7F321F09CB","8028A058-B662-45A8-A1B2-52F94F314911","8028A058-B662-45A8-A1B2-52F94F314911"]
        )
    ]
}
