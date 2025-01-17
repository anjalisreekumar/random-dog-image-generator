//
//  GenerateViewModel.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 17/01/25.
//

import Foundation
import UIKit

class GenerateViewModel {
    let dogService = DogImageService()
    
    var onClickGenerate: ((UIImage) -> Void)?
    var onError: ((String) -> Void)?
    
    
    func fetchDogImage(){
        dogService.fetchRandomDogImage { result in
            switch result {
            case .success(let image):
                self.onClickGenerate?(image)
            case .failure(let error):
                self.handleErrors(error)
            }
        }
    }
    
    func handleErrors(_ error: NetworkError) {
        switch error {
            case .decodingFailed:
            onError?("Decoding failed")
        case .invalidURL:
            onError?("Invalid URL")
        case .noInternetConnection:
            onError?("No internet connection")
        case .requestFailed:
            onError?("Request failed")
        }
    }
    
}
