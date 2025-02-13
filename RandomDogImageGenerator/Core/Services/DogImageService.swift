//
//  DogImageService.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import Foundation
import UIKit

class DogImageService {
    
    let imageHandler = ImageCacheManager.shared
    
    func fetchRandomDogImage(completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard NetworkConnectivity.shared.isConnected else {
            completion(.failure(.noInternetConnection))
            return
        }
        guard let url = APIEndpoint.randomDogImage() else {
            completion(.failure(.invalidURL))
            return
        }
        NetworkService.shared.fetch(url: url) { (result: Result<DogImageResponse,NetworkError>) in
            switch result {
            case .success(let response):
                self.downloadImage(from: response.message, completion: completion)
            case.failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        if let cachedImage = imageHandler.getImage(urlString) {
            completion(.success(cachedImage))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            self.imageHandler.addImage(urlString, image)
            completion(.success(image))
        }
        
        task.resume()
    }
    
    
}
