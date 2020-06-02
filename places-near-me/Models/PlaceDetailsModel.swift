//
//  PlaceDetailsModel.swift
//  places-near-me
//
//  Created by aisenur on 29.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation
import CoreLocation

struct PlaceDetails: Decodable {
    let id: String
    let price: String
    let phone: String
    let rating: Double
    let name: String
    let isClosed: Bool
    let photos: [URL]
    let coordinates: CLLocationCoordinate2D
    let categories: [Category]
}

struct Category: Decodable {
    let alias: String
    let title: String
}

extension CLLocationCoordinate2D: Decodable {
    enum Keys: CodingKey {
        case latitude
        case longitude
    }
    
    public init(from decoder: Decoder) throws {
        let cont = try decoder.container(keyedBy: Keys.self)
        let lat = try cont.decode(Double.self, forKey: .latitude)
        let long = try cont.decode(Double.self, forKey: .longitude)
        
        self.init(latitude: lat, longitude: long)
    }
}

struct PlaceDetailsViewModel {
    let id: String
    let placeName: String
    let phoneNumber: String
    let price: String
    let isClosed: String
    let rating: Double
    let placePhotos: [URL]
    let coordinates: CLLocationCoordinate2D
    let categories: [Category]
    
    init(detail: PlaceDetails) {
        self.id = detail.id
        self.placeName = detail.name
        self.phoneNumber = detail.phone
        self.price = detail.price
        self.isClosed = detail.isClosed ? "Close" : "Open"
        self.rating = detail.rating
        self.placePhotos = detail.photos
        self.coordinates = detail.coordinates
        self.categories = detail.categories
    }
}
