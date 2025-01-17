//
//  APIEndpoint.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 17/01/25.
//

import Foundation

struct APIEndpoint {
    static let baseURL = "https://dog.ceo/api"
    
    static func randomDogImage() -> URL? {
        return URL(string: "\(baseURL)/breeds/image/random")
    }
}
