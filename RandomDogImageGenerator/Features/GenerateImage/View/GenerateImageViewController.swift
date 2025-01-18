//
//  GenerateImageViewController.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 17/01/25.
//

import UIKit

class GenerateImageViewController: UIViewController {

    @IBOutlet weak var dogImageview: UIImageView!
    
    @IBOutlet weak var generateButton: UIButton!
    
    private let viewModel = GenerateViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.onClickGenerate = { [weak self] image in
            DispatchQueue.main.async {
                self?.dogImageview.image = image
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(errorMessage: errorMessage)
            }
        }
    }
    
    private func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    
    @IBAction func didTapGenerateButton(_ sender: Any) {
        
        viewModel.fetchDogImage()
    }
    

}
