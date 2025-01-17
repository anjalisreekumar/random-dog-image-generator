//
//  ImageCacheManager.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 17/01/25.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()  // Singleton instance

    private let imageCache = LRUCache(capacity: 20)
    
    private init() { }

    // Save image to cache
    func saveImageToCache(_ image: UIImage, for key: String) -> String {
        if let _ = imageCache.get(key: key) {
            return "Image already exists. Not saved."
        } else {
            imageCache.put(key: key, value: image)
            return "Image saved successfully."
        }
    }
    
    // Fetch all images from cache
    func fetchAllImagesFromCache() -> [UIImage] {
        var images = [UIImage]()
        
        // Get all images from the cache
        for key in imageCache.cache.keys {
            if let image = imageCache.get(key: key) {
                images.append(image)
            }
            
        }
        return images
    }
    
    // Clear cache
    func clearCache() {
        imageCache.clearCache()
    }
}
