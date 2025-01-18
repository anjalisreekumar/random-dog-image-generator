//
//  HomeViewController.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 17/01/25.
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
        // Setup button and label properties
        titleLabel.text = "Random Dog Image Generator"
        generateButton.setTitle("Generate Dogs!", for: .normal)
        recentButton.setTitle("My Recently Generated Dogs!", for: .normal)
        
        // Set background color
        generateButton.backgroundColor = .customColour
        recentButton.backgroundColor = .customColour
        
        // Maintain capsule shape and fill color
        generateButton.layer.cornerRadius = generateButton.frame.height / 2
        recentButton.layer.cornerRadius = recentButton.frame.height / 2
        
        // Ensure the button has its color filled (not just border)
        generateButton.layer.masksToBounds = true
        recentButton.layer.masksToBounds = true
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
