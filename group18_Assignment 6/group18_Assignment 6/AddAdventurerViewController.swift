//
//  AddAdventurerViewController.swift
//  group18_Assignment 6
//
//  Created by Hoej, Christian R on 10/20/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit

class AddAdventurerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var enterClass: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addAdventurerCollectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
    
    let adventurerImages: [UIImage] = [
        UIImage(named: "abra")!,
        UIImage(named: "eevee")!,
        UIImage(named: "pikachu")!
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAdventurerCollectionView.dataSource=self
        addAdventurerCollectionView.delegate=self
    }
    
    @IBAction func addAdventurerTapped(_ sender: Any) {
        if (enterName.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) || (enterClass.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) {
            let alert = UIAlertController(title: "No input", message: "Please enter both Name and Class", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
         else{
            //TODO: Add code to add adventurer to core data
        
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appearanceCell", for: indexPath) as! AddAdventurerCollectionViewCell
        
        cell.adventurerImageView.image = adventurerImages[indexPath.item]
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
