//
//  ImageCacheManager.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 17/01/25.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let imageCache = LRUCache(capacity: 20)
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true,attributes: nil)
        }
        catch {
            fatalError("Could not create file")
        }
        loadCacheFromDisk()
    }
    
    
    private func loadCacheFromDisk() {
        let fileManager = FileManager.default
        
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for fileUrl in fileUrls {
                if let imageData = try? Data(contentsOf: fileUrl), let image = UIImage(data: imageData) {
                    let key = fileUrl.lastPathComponent
                    imageCache.put(key: key, value: image)
                }
            }
        }
        catch {
            print("Error loading cache from disk: \(error)")
        }
        
    }
    
    private func saveImageToDisk(_ image: UIImage, for key: String) {
        guard let imageData = image.pngData() else {
            print("Failed to convert image to data")
            return
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("Error saving image to disk: \(error)")
        }
    }
    
    // Save image to cache
    func saveImageToCache(_ image: UIImage, for key: String) -> String {
        if let _ = imageCache.get(key: key) {
            return "Image already exists. Not saved."
        } else {
            imageCache.put(key: key, value: image)
            return "Image saved successfully."
        }
    }
    
    func fetchImageFromCache(for key: String) -> UIImage? {
        return imageCache.get(key: key)
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
