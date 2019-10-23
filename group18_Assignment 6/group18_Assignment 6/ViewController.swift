//
//  ViewController.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/17/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate {
    //MARK: Properties
    @IBOutlet weak var adventurerTableView: UITableView!
    
    var adventurers: [NSManagedObject] = []
    var deleteAdventurerIndexPath: NSIndexPath? = nil
    
    //MARK:Methods
    //Function to save data to CoreData
    func save(name: String, adventurerClass: String, image: UIImage, level: Int, currentHP: Int, totalHP: Int, attack: Float) {
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
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: NSIndexPath) {
        if editingStyle == .delete {
            deleteAdventurerIndexPath = indexPath
            let adventurerToDelete = adventurers[indexPath.row]
            confirmDelete(adventurer: adventurerToDelete)
        }
    }
    
    func confirmDelete(adventurer: NSObject) {
        let advName = adventurer.value(forKeyPath: "name")
        let alert = UIAlertController(title: "Delete Adventurer", message: "Are you sure you want to delete \(String(describing: advName))?", preferredStyle: .actionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteAdventurer)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteAdventurer)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
    }
    
    func handleDeleteAdventurer(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteAdventurerIndexPath {
            adventurers.remove(at: indexPath.row)
            //self.adventurerTableView.reloadData()
            adventurerTableView.deleteRows(at: [(indexPath as IndexPath)], with: .fade)
            deleteAdventurerIndexPath = nil
        }
    }
    
    func cancelDeleteAdventurer(alertAction: UIAlertAction!) {
        deleteAdventurerIndexPath = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adventurerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Adventurer")

      do {
        adventurers = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    //MARK: Actions
    @IBAction func unwindToAdventurerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddAdventurerViewController, let adventure = sourceViewController.adventure {
            self.save(name: adventure.name, adventurerClass: adventure.adClass, image: adventure.image, level: adventure.level, currentHP: adventure.currentHP, totalHP: adventure.currentHP, attack: adventure.attack)
        }
        self.adventurerTableView.reloadData()
    }
    
    //When unwinding from quest, regain hit points ==> currentHP = totalHP
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return adventurers.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let adventurer = adventurers[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "adventurerCell", for: indexPath) as! AdventurerTableViewCell
    
    cell.adName?.text = adventurer.value(forKeyPath: "name") as? String
    cell.adLevel?.text = "\(adventurer.value(forKeyPath: "level") as? Int ?? 0)"
    cell.adProfession?.text = adventurer.value(forKeyPath: "adventurerClass") as? String
    cell.adImage?.image = adventurer.value(forKeyPath: "image") as? UIImage
    let attackFl = adventurer.value(forKeyPath: "attack") as? Float
    cell.adAttack?.text = String(format: "%.2f", attackFl ?? 0)
    let currentHPStatus = adventurer.value(forKeyPath: "currentHP") as? Int
    let totalHPStatus = adventurer.value(forKeyPath: "totalHP") as? Int
    cell.adHP?.text = "\(currentHPStatus ?? 0)"+"/"+"\(totalHPStatus ?? 0)"
    
    return cell
  }
}
