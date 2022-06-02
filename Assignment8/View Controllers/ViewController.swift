//
//  ViewController.swift
//  Assignment8
//
//  Created by Kaiya Takahashi on 2022-05-28.
//

import UIKit

private var menus: [Restaurant] = [
  Restaurant(country: Restaurant.FoodType.japanese, name: "Minami", description: "Sushi Restaurant", price: "$$", image: UIImage(named: "Japanese")!),
  Restaurant(country: Restaurant.FoodType.japanese, name: "Nobu", description: "Sushi Restaurant", price: "$$$$", image: UIImage(named: "Japanese2")!),
  Restaurant(country: Restaurant.FoodType.japanese, name: "Japanese 3", description: "Sushi Restaurant", price: "$$$$", image: UIImage(named: "Japanese2")!),
  Restaurant(country: Restaurant.FoodType.chinese, name: "Egg fried rice", description: "fried rice with eggs", price: "$", image: UIImage(named: "Chinese")!),
  Restaurant(country: Restaurant.FoodType.korean, name: "Korean BBQ", description: "very spicy", price: "$$", image: UIImage(named: "Korean")!),
  Restaurant(country: Restaurant.FoodType.indian, name: "Curry", description: "spicy", price: "$", image: UIImage(named: "Indian")!),
  Restaurant(country: Restaurant.FoodType.british, name: "Cheers Mate", description: "Chinese and Pizza", price: "$", image: UIImage(named: "British")!),
  Restaurant(country: Restaurant.FoodType.french, name: "Mercy", description: "anything", price: "$$$", image: UIImage(named: "French")!),
  Restaurant(country: Restaurant.FoodType.italian, name: "Bonapetito", description: "pizza", price: "$$$", image: UIImage(named: "Italian")!),
  Restaurant(country: Restaurant.FoodType.spanish, name: "Ola", description: "famous for paella", price: "$$", image: UIImage(named: "Spanish")!),
  Restaurant(country: Restaurant.FoodType.american, name: "McDonald", description: "burger", price: "$", image: UIImage(named: "American")!),
  Restaurant(country: Restaurant.FoodType.mexican, name: "Taco Bell", description: "Taco Restaurant", price: "$", image: UIImage(named: "Mexican")!),
]

private var foodTypes: [(type: Restaurant.FoodType, isTapped: Bool)] = Restaurant.FoodType.allCases.map { ($0, false) }

class ViewController: UIViewController {
  
  enum MenuSection: CaseIterable {
    case main
  }
  
  @IBOutlet var typeCollectionView: UICollectionView!
  @IBOutlet var menuCollectionView: UICollectionView!
  
  var filteredMenus: [Restaurant] = menus
  var menuCollectionViewDataSource: UICollectionViewDiffableDataSource<MenuSection, Restaurant>!
  var filteredSnapshot: NSDiffableDataSourceSnapshot<MenuSection, Restaurant> {
    var snapshot = NSDiffableDataSourceSnapshot<MenuSection, Restaurant>()
    snapshot.appendSections([.main])
    snapshot.appendItems(filteredMenus)
    return snapshot
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTypeCellLayout()
    setupMenuCellLayout()
    generateDataSourceForMenu()
  }
  
  func setupTypeCellLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: typeCollectionView.frame.width / 3, height: typeCollectionView.frame.height / 2)
    layout.sectionInset = UIEdgeInsets(
      top: 5,
      left: 5,
      bottom: 5,
      right: 5
    )
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 100
    layout.minimumLineSpacing = 10
    typeCollectionView.collectionViewLayout = layout
  }
  
  func setupMenuCellLayout() {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(
      top: menuCollectionView.frame.height/30,
      left: menuCollectionView.frame.width * 0.03,
      bottom: menuCollectionView.frame.height/30,
      right: menuCollectionView.frame.width * 0.03
    )
    layout.itemSize = CGSize(width: menuCollectionView.frame.width * 0.45, height: menuCollectionView.frame.height / 3)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = menuCollectionView.frame.width * 0.04
    menuCollectionView.collectionViewLayout = layout
  }
  
  private func generateDataSourceForMenu() {
    menuCollectionViewDataSource = UICollectionViewDiffableDataSource<MenuSection, Restaurant>(collectionView: menuCollectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
      let cell = self.menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! MenuCollectionViewCell
      cell.configure(itemIdentifier, with: self.menuCollectionView)
      cell.backgroundColor = .white
      return cell
    })
    
    menuCollectionViewDataSource.apply(filteredSnapshot)
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return foodTypes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = typeCollectionView.dequeueReusableCell(withReuseIdentifier: "typeCell", for: indexPath) as! TypeCollectionViewCell
    let foodType = foodTypes[indexPath.item]
    cell.configure(foodType.type.rawValue, isTapped: foodType.isTapped)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! TypeCollectionViewCell
    foodTypes[indexPath.row].isTapped.toggle()
    typeCollectionView.reloadSections(IndexSet(integer: 0))
    
    let type = cell.typeLabel.text!
    filteredMenus = menus.filter { menu in
      if type == "All" {
        return true
      } else {
        let filteredTypes = foodTypes.filter { $1 }
        return filteredTypes.contains { $0.type == menu.country }
      }
    }
    
    menuCollectionViewDataSource.apply(filteredSnapshot, animatingDifferences: true)
  }
}

