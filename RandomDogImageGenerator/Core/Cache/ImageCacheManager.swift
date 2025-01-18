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
    
    let imageCache: LRUCache
    private let persistance = PersistanceManager()
    private var isMetaDataDirty = false
    
    private init() {
        imageCache = LRUCache(capacity: 20)
        imageCache.onEviction = {[weak self] evictedKey in
            self?.persistance.deleteImage(evictedKey)
            self?.isMetaDataDirty = true
        }
        loadCacheState()
    }
    
    private func loadCacheState() {
        let keys = persistance.loadMetaData()
        let reversedKeys = keys?.reversed() ?? []

        reversedKeys.forEach({ key in
            if let image = persistance.loadImage(key) {
                imageCache.put(key: key, value: image)
            }
        })
    }
    
    func addImage(_ key: String, _ image: UIImage) {
        imageCache.put(key: key, value: image)
        persistance.saveImage(key, image)
        persistCache()
        isMetaDataDirty = true
        
    }
    
    func getImage(_ key: String) -> UIImage? {
        return imageCache.get(key: key) ?? persistance.loadImage(key)
    }
    
    
    func clearCache() {
        imageCache.clearCache()
        persistance.clearAllImages()
        persistance.saveMetaData([])
        print("Successfully Cleared Cache ✅")
    }
    
    
    func persistCache() {
        if isMetaDataDirty {
            persistance.saveMetaData(imageCache.getAllKeys())
            isMetaDataDirty = false
        }
    }

}
