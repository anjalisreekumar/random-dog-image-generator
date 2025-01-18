//
//  GalleryViewModel.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 18/01/25.
//

import Foundation

class GalleryViewModel {
    private(set) var imageNames: [String] = [
        "house",
        "person.circle",
        "star",
        "bell",
        "heart",
        "envelope",
        "gear",
        "magnifyingglass",
        "trash",
        "bookmark",
        "flag",
        "paperplane",
        "cloud",
        "calendar",
        "cart",
        "camera",
        "folder",
        "link",
        "pencil",
        "lock"
    ]
    
    var onClearButtonTapped: (() -> Void)?
    
    
    func clearAllImages(){
        imageNames.removeAll()
        onClearButtonTapped?()
    }
    
    
}
