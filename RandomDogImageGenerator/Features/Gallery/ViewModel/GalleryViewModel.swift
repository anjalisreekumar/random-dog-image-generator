//
//  GalleryViewModel.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 18/01/25.
//

import Foundation
import UIKit

class GalleryViewModel {
    let imageHandler = ImageCacheManager.shared
    var onImageDataUpdate: (() -> Void)?
    var onImagesLoaded: (() -> Void)?
    var imageArray: [UIImage] = []
    
    func clearAllImages() {
        imageHandler.clearCache()
        imageArray = []
        onImageDataUpdate?()
    }
    
    func loadImages() {
        let images = imageHandler.imageCache.getAllImages()
        imageArray = images
        onImageDataUpdate?()
    }
}

