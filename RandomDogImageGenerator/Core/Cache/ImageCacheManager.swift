//
//  ImageCacheManager.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import Foundation
import UIKit
class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let imageCache = LRUCache(capacity: 6)
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            fatalError("Could not create file")
        }
        loadCacheFromDisk()
    }
    
    private func loadCacheFromDisk() {
        let fileManager = FileManager.default
        
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileUrl in fileUrls {
                if let imageData = try? Data(contentsOf: fileUrl),
                   let image = UIImage(data: imageData) {
                    let key = fileUrl.lastPathComponent
                    imageCache.put(key: key, value: image)
                }
            }
        } catch {
            print("Error loading cache from disk: \(error)")
        }
    }
    
    private func saveImageToDisk(_ image: UIImage, for key: String) {
        guard let imageData = image.pngData() else { return }
        let fileURL = cacheDirectory.appendingPathComponent(sanitizeKey(key))
        
        do {
            try imageData.write(to: fileURL)
        } catch {
            print("Error saving image to disk: \(error)")
        }
    }
    
    func saveImageToCache(_ image: UIImage, for key: String) -> String {
        if let _ = imageCache.get(key: key) {
            return "Image already exists. Not saved."
        } else {
            imageCache.put(key: key, value: image)
            saveImageToDisk(image, for: key) // Save to disk
            return "Image saved successfully."
        }
    }
    
    func fetchImageFromCache(for key: String) -> UIImage? {
        return imageCache.get(key: key)
    }
    
    func fetchAllImagesFromCache() -> [UIImage] {
        return imageCache.getAllImages()
    }
    
    func clearCache() {
        imageCache.clearCache()
        clearAllCacheFromDisk()
    }
    
    private func clearAllCacheFromDisk() {
        let fileManager = FileManager.default
        do {
            let fileUrls = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileUrl in fileUrls {
                try fileManager.removeItem(at: fileUrl)
            }
        } catch {
            print("Error clearing cache from disk: \(error)")
        }
    }
    
    func saveAllCacheToDisk() {
        for key in imageCache.cache.keys {
            if let image = imageCache.get(key: key) {
                saveImageToDisk(image, for: key)
            }
        }
    }
    
    private func sanitizeKey(_ key: String) -> String {
        return key.replacingOccurrences(of: "/", with: "_")
    }
}
