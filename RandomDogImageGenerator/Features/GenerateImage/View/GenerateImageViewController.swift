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
    private var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupActivityIndicator()

    }
    
    private func setupUI(){
        generateButton.setTitle("Generate!", for: .normal)
        generateButton.backgroundColor = .customColour
        generateButton.setCurvedCorner()
        generateButton.setCurvedCorner()
    }
    
    private func setupActivityIndicator() {
          activityIndicator = UIActivityIndicatorView(style: .large)
          activityIndicator.color = .gray
          activityIndicator.translatesAutoresizingMaskIntoConstraints = false
          dogImageview.addSubview(activityIndicator)
          
          NSLayoutConstraint.activate([
              activityIndicator.centerXAnchor.constraint(equalTo: dogImageview.centerXAnchor),
              activityIndicator.centerYAnchor.constraint(equalTo: dogImageview.centerYAnchor)
          ])
      }
    
    private func setupBindings() {
        viewModel.onClickGenerate = { [weak self] image in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.dogImageview.image = image
            }
        }
        
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
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
        activityIndicator.startAnimating()
        viewModel.fetchDogImage()
    }
    

}
