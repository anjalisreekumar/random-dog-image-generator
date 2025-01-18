//
//  ImageGalleryViewController.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 18/01/25.
//

import UIKit

class ImageGalleryViewController: UIViewController {

    private var clearButton: UIButton = {
      let button = UIButton()
        button.setTitle("Clear!", for: .normal)
        button.backgroundColor = .customColour
        button.layer.cornerRadius = 30 / 2
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var imageCollectionView: UICollectionView?
 
    private let viewModel = GalleryViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupButton()
        setupBindings()
        viewModel.loadImages()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageCollectionView?.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 270).integral //rounding to int
    }
    
    private func setupUI(){
        navigationItem.title = "My Recently Generated Dogs!"
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 270)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollectionView?.showsHorizontalScrollIndicator = false
        imageCollectionView?.delegate = self
        imageCollectionView?.dataSource = self
        
        imageCollectionView?.register(ImageGalleryCollectionViewCell.self, forCellWithReuseIdentifier: ImageGalleryCollectionViewCell.identifier)
        guard let myCollection = imageCollectionView else {
            return
        }
        view.addSubview(myCollection)
    }

    private func setupButton() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.topAnchor.constraint(equalTo: imageCollectionView!.bottomAnchor, constant: 50),
            clearButton.heightAnchor.constraint(equalToConstant: 30),
            clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
        
        clearButton.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
    }
    
    
    @objc private func didTapClear(){
        viewModel.clearAllImages()
    }
    
    private func setupBindings(){
        viewModel.onImageDataUpdate = { [weak self] in
            self?.imageCollectionView?.reloadData()
        }
    }
}

extension ImageGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGalleryCollectionViewCell.identifier, for: indexPath) as! ImageGalleryCollectionViewCell
        cell.configure(with: viewModel.imageArray[indexPath.row])
        return cell
    }
    
}
