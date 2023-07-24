//
//  MainCell.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import UIKit

class MainCell: UICollectionViewCell {
    static let reuseIdentifier = "MainCell"
    
    let pictureView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pictureView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
