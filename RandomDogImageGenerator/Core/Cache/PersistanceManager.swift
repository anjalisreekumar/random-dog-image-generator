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
    private let ioQueue = DispatchQueue(label: "com.imagecachemanager.ioQueue", attributes: .concurrent)
    
    
    init() {
        let cacheDirectoryURLs = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cacheDirectoryURLs.appendingPathComponent("ImageCache")
        metadataURL = cacheDirectoryURLs.appendingPathExtension("metadata.json")
        // Ensure the "ImageCache" directory exists
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
                print("Cache directory created: \(cacheDirectory.path)")
            } catch {
                print("Error creating cache directory: \(error)")
            }
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
        let sanitizedKey = sanitizeKey(key)
        ioQueue.async {
            guard let data = image.jpegData(compressionQuality: 1.0) else {
                print("Error: Image data is empty or invalid.")
                return
            }
            let fileURL = self.cacheDirectory.appendingPathComponent(sanitizedKey)
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error saving image to disk: \(error)")
            }
        }
    }
    
    
    //load images from disk
    
    func loadImage(_ key: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(sanitizeKey(key))
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    //clears single image
    
    func deleteImage(_ key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(sanitizeKey(key))
        try? fileManager.removeItem(at: fileURL)
    }
    
    //clear all images
    
    func clearAllImages() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    private func sanitizeKey(_ key: String) -> String {
        // Replace slashes and other unsafe characters with underscores
        return key
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: ":", with: "_")  // Optional: handles colon in URLs
            .replacingOccurrences(of: ".", with: "_")  // Optional: handles dot
    }
    
}
