//
//  Business.swift
//  places-near-me
//
//  Created by aisenur on 22.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import CoreLocation

struct business: Codable {
    let id: String
    let name: String
    let imageUrl: URL
    let distance: Double
    let rating: Double
}

struct AllData: Codable {
    let businesses: [business]
}

struct PlaceListViewModel {
    let id: String
    let placeName: String
    let imageURL: URL
    let distance: String
    let rating: Double
    
    init(place: business) {
        self.id = place.id
        self.placeName = place.name
        self.imageURL = place.imageUrl
        self.distance = "\(String(format: "%.2f", place.distance/1000))" //convert meter to km
        self.rating = place.rating
        print(place.rating)
    }
}

