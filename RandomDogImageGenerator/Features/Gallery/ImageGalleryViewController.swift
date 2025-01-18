//
//  ImageGalleryViewController.swift
//  RandomDogImageGenerator
//
//  Created by Bridge Global on 18/01/25.
//

import UIKit

class ImageGalleryViewController: UIViewController {

    private var clearButton: UIButton = {
      let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = .customColour
        button.layer.cornerRadius = 50 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var imageCollectionView: UICollectionView?
    
    let imageNames = [
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageCollectionView?.frame = CGRect(x: 0, y: 200, width: view.frame.size.width, height: 300).integral//rounding to int
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 300)
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
    }
}




extension ImageGalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageGalleryCollectionViewCell.identifier, for: indexPath) as! ImageGalleryCollectionViewCell
        cell.configure(with: imageNames[indexPath.row])
        return cell
    }
    
}
