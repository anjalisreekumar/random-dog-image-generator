//
//  ImageGalleryCollectionViewCell.swift
//  RandomDogImageGenerator
//
//  Created by Anjali on 18/01/25.
//

import UIKit

class ImageGalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageGalleryCollectionViewCell"
    
    private let myImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageview.frame = contentView.bounds
        
    }
    
    public func configure(with image: UIImage) {
        myImageview.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageview.image = nil
    }
}
