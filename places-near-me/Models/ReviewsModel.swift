//
//  ReviewsModel.swift
//  places-near-me
//
//  Created by aisenur on 29.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import Foundation

struct User: Decodable {
    let imageUrl: URL
    let name: String
}

struct Review: Decodable {
    let rating: Double
    let text: String
    let user: User
    let timeCreated: String
}

struct Response: Decodable {
    let reviews: [Review]
}
