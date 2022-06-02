//
//  MenuCollectionViewCell.swift
//  Assignment8
//
//  Created by Kaiya Takahashi on 2022-05-28.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var menuImageView: UIImageView!
    @IBOutlet var menuNameLabel: UILabel!
    @IBOutlet var menuPriceLabel: UILabel!
    @IBOutlet var menuDescriptionLabel: UILabel!
    
    func configure(_ restaurant: Restaurant, with collectionView: UICollectionView) {
        let size = CGSize(
            width: collectionView.frame.width * 0.45,
            height: collectionView.frame.height / 3 - 100
        )
        UIGraphicsBeginImageContext(size)
        restaurant.image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        menuImageView.image = scaledImage
        menuNameLabel.text = restaurant.name
        menuPriceLabel.text = restaurant.price
        menuDescriptionLabel.text = restaurant.description
    }
}
