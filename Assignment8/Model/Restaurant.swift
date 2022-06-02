//
//  Restaurant.swift
//  Assignment8
//
//  Created by Kaiya Takahashi on 2022-05-28.
//

import Foundation
import UIKit

struct Restaurant: Hashable {
  
  let country: FoodType
  let name: String
  let description: String
  let price: String
  let image: UIImage
  
  enum FoodType: String, CaseIterable {
    case all = "All", japanese = "Japanese", chinese = "Chinese", korean = "Korean", indian = "Indian", british = "British", french = "French", italian = "Italian", spanish = "Spanish", american = "American", mexican = "Mexican"
  }
  
  static func scaleImageToSize(_ img: UIImage, _ size: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    img.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
    return scaledImage
  }
  
}
