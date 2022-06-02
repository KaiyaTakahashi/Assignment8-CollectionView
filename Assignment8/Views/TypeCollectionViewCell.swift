//
//  TypeCollectionViewCell.swift
//  Assignment8
//
//  Created by Kaiya Takahashi on 2022-05-28.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet var typeLabel: UILabel!
  var isTapped: Bool = false
  
  func configure(_ foodType: String, isTapped: Bool) {
    self.typeLabel.text = foodType
    self.layer.cornerRadius = 10.0
    self.contentView.layer.cornerRadius = 10.0
    self.contentView.layer.borderWidth = 1.0
    self.contentView.layer.borderColor = UIColor.clear.cgColor
    self.layer.masksToBounds = true
    self.backgroundColor = .white
    self.backgroundColor = isTapped ? .gray : .white
  }
  
}
