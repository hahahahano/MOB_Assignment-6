//
//  AddAdventurerViewController.swift
//  group18_Assignment 6
//
//  Created by Hoej, Christian R on 10/20/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData
import os.log

class AddAdventurerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate {
    //MARK:Properties
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var enterClass: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addAdventurerCollectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
    var chosenImage: UIImage? = UIImage(named: "default")
    
    let adventurerImages: [UIImage] = [
        UIImage(named: "abra")!,
        UIImage(named: "bulbasaur")!,
        UIImage(named: "charmander")!,
        UIImage(named: "eevee")!,
        UIImage(named: "magikarp")!,
        UIImage(named: "pikachu")!
    ]
    
    var adventure: adventurer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAdventurerCollectionView.dataSource=self
        addAdventurerCollectionView.delegate=self
    }
    
    var adventurerAdded: Bool = false
    //Function when the save button is tapped
    /*@IBAction func addAdventurerTapped(_ sender: Any) {
        //Checks for whitespace/empty textfields
        if (enterName.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) || (enterClass.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) || (chosenImage?.isEqual(UIImage(named: "default")) ?? false){
            let alert = UIAlertController(title: "No input", message: "Please enter a name, class, and choose an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            adventurerAdded = true
            let nameToSave = self.enterName.text
            let classToSave = self.enterClass.text
            let imageToSave = chosenImage!
            let levelToSave = 1
            let totalHP = Int.random(in: 90..<151)
            let currentHPToSave = totalHP
            let totalHPToSave = totalHP
            let attackToSave = Float.random(in: 2..<5.1)
            
            self.save(name: nameToSave ?? "ERROR", adventurerClass: classToSave ?? "ERROR" , image: imageToSave, level: levelToSave, currentHP: currentHPToSave, totalHP: totalHPToSave, attack: attackToSave)
            
            let alert2 = UIAlertController(title: "Adventurer added!", message: "Your adventurer has been added to your collection! Go back to see it in the list", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert2, animated: true)
            
            enterName.text=""
            enterClass.text=""
        }
    }*/
    
    //Function to save data to CoreData
    /*func save(name: String, adventurerClass: String, image: UIImage, level: Int, currentHP: Int, totalHP: Int, attack: Float) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
        
      let managedContext = appDelegate.persistentContainer.viewContext

      let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
      
      let adventurer = NSManagedObject(entity: entity, insertInto: managedContext)
        adventurer.setValue(name, forKeyPath: "name")
        adventurer.setValue(adventurerClass, forKeyPath: "adventurerClass")
        adventurer.setValue(image.pngData(), forKeyPath: "image")
        adventurer.setValue(level, forKey: "level")
        adventurer.setValue(totalHP, forKey: "currentHP")
        adventurer.setValue(totalHP, forKey: "totalHP")
        adventurer.setValue(attack, forKey: "attack")
      do {
        try managedContext.save()
        adventurers.append(adventurer)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }*/

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adventurerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appearanceCell", for: indexPath) as! AddAdventurerCollectionViewCell
        
        cell.adventurerImageView.image = adventurerImages[indexPath.item]
        
        return cell
    }
    
    //Selecting image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 3.0
        cell?.layer.borderColor = UIColor.blue.cgColor
        
        chosenImage = self.adventurerImages[indexPath.row]
    }
    
    //Deselecting image
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        
        chosenImage = self.adventurerImages[indexPath.row]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === addButton else {
            os_log("The Add Adventurer button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //Checks for whitespace/empty textfields
        if (enterName.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) || (enterClass.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) || (chosenImage?.isEqual(UIImage(named: "default")) ?? false){
            let alert = UIAlertController(title: "No input", message: "Please enter a name, class, and choose an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        else{
            adventurerAdded = true
            let nameToSave = self.enterName.text
            let classToSave = self.enterClass.text
            let imageToSave = chosenImage!
            let totalHP = Int.random(in: 90..<151)
            let levelToSave = 1
            let currentHPToSave = totalHP
            let totalHPToSave = totalHP
            let attackToSave = Float.random(in: 2..<5.1)
            
            adventure = adventurer(name: nameToSave ?? "ERROR", adClass: classToSave ?? "ERROR" , image: imageToSave, level: levelToSave, currentHP: currentHPToSave, totalHP: totalHPToSave, attack: attackToSave)
            
            /*let alert2 = UIAlertController(title: "Adventurer added!", message: "Your adventurer has been added to your collection! Go back to see it in the list", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert2, animated: true)
            
            enterName.text=""
            enterClass.text=""*/
        }
    }

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
