//
//  NetworkService.swift
//  places-near-me
//
//  Created by aisenur on 22.05.2020.
//  Copyright © 2020 aisenur. All rights reserved.
//

import UIKit
import Moya

private let apiKey = "CEDelXgQkDGslnKNRjFVyYQXVt--nB-fzmakueZdcRI7pigMffdhL4MKlCGp2ZJq4tRdQtLUoCxF9_DGKssDcDV6VB4zfxIijS9V3zgdG4-Yw2F96NHxNKoo_dXHXnYx"
private let clientId = "HAXMImlrR6saM8RhNJ-_AA"

enum YelpServices {
    
    enum DataProvider: TargetType {
        
        case search(lat: Double, long: Double)
        case searchFilter(lat: Double, long: Double, filter: String)
        case details(id: String)
        case reviews(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case .search: return "/search"
            case .searchFilter: return "/search"
            case .details(let id): return "/\(id)"
            case .reviews(let id): return "/\(id)/reviews"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 30, "radius": 40000], encoding: URLEncoding.queryString)
            case .details(_):
                return .requestPlain
            case let .searchFilter(lat, long, filter):
                return .requestParameters(parameters: ["latitude": lat, "longitude": long, "limit": 30, "term": filter, "radius": 40000], encoding: URLEncoding.queryString)
            case .reviews(_):
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}

