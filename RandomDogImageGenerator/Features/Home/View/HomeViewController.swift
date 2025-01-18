//
//  HomeViewController.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var generateButton: UIButton!
    
    @IBOutlet weak var recentButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = "Random Dog Image Generator"
        generateButton.setTitle("Generate Dogs!", for: .normal)
        recentButton.setTitle("My Recently Generated Dogs!", for: .normal)
        generateButton.setBlackBorder()
        recentButton.setBlackBorder()
        generateButton.backgroundColor = .customColour
        recentButton.backgroundColor = .customColour
        generateButton.setCurvedCorner()
        recentButton.setCurvedCorner()
    }


    @IBAction func didTapGenerateButton(_ sender: Any) {
        // navigate to GenerateViewController
        if let generateVC = storyboard?.instantiateViewController(identifier: "GenerateImageViewController") as? GenerateImageViewController {
            navigationController?.pushViewController(generateVC, animated: true)
            
        }
    }
    
    @IBAction func didTapRecentButton(_ sender: Any) {
        //navigate to GalleryViewController
        if let galleryVC = storyboard?.instantiateViewController(identifier: "ImageGalleryViewController") as? ImageGalleryViewController {
            navigationController?.pushViewController(galleryVC, animated: true)
            
        }
        
    }
    
}
