//
//  PersistanceManager.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 18/01/25.
//

import Foundation
import UIKit

class PersistanceManager {
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let metadataURL: URL
    
    init() {
        let cacheDirectoryURLs = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cacheDirectoryURLs.appendingPathComponent("ImageCache")
        metadataURL = cacheDirectoryURLs.appendingPathExtension("metadata.json")
        
        if fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
        
    }
    //load metadata
    func loadMetaData() -> [String]? {
        guard let data = try? Data(contentsOf: metadataURL),
              let keys = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return keys
        
    }
    //save metadata
    func saveMetaData(_ keys: [String]) {
        let data = try! JSONEncoder().encode(keys)
        try! data.write(to: metadataURL)
    }
    //save image to disk
    
    func saveImage(_ key: String, _ image: UIImage) {
        guard let data = image.pngData() else { return }
        let fileURL = cacheDirectory.appendingPathComponent("\(key).png")
        try? data.write(to: fileURL)
    }
    
    //load images from disk
    
    func loadImage(_ key: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent("\(key).png")
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    //clears single image
    
    func deleteImage(_ key: String) {
           let fileURL = cacheDirectory.appendingPathComponent("\(key).png")
           try? fileManager.removeItem(at: fileURL)
       }
    
    //clear all images
    
    func clearAllImages() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
  
}
