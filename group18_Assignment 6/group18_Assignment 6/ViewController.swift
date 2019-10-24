//
//  ViewController.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/17/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData
import os.log

class ViewController: UIViewController, UITableViewDelegate {
    //MARK: Properties
    @IBOutlet weak var adventurerTableView: UITableView!
    
    var adventurers: [NSManagedObject] = []
    var deleteAdventurerIndexPath: NSIndexPath? = nil
    
    //MARK:Methods
    //Saves data to CoreData
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
    
    //Deleting data (***I can't get this to appear, so I don't know if the code I wrote works or not)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: NSIndexPath) {
        if editingStyle == .delete {
            deleteAdventurerIndexPath = indexPath
            let adventurerToDelete = adventurers[indexPath.row]
            confirmDelete(adventurer: adventurerToDelete)
        }
    }
    
    //Alert to confirm delete
    func confirmDelete(adventurer: NSObject) {
        let advName = adventurer.value(forKeyPath: "name")
        let alert = UIAlertController(title: "Delete Adventurer", message: "Are you sure you want to delete \(String(describing: advName))?", preferredStyle: .actionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteAdventurer)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteAdventurer)
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
    }
        //Handling deleting the data
    func handleDeleteAdventurer(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteAdventurerIndexPath {
            adventurers.remove(at: indexPath.row)
            //self.adventurerTableView.reloadData()
            adventurerTableView.deleteRows(at: [(indexPath as IndexPath)], with: .fade)
            deleteAdventurerIndexPath = nil
        }
    }
        //Cancelling the deleting
    func cancelDeleteAdventurer(alertAction: UIAlertAction!) {
        deleteAdventurerIndexPath = nil
    }
        //Confirming that the table is editable (***I don't know if this is needed)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Loading the screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        adventurerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    //Fetching the core data
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
        } else if let sourceViewController = sender.source as? QuestViewController {
            //regaining HP (current HP = total HP)
            //Refresh table (make sure that the level is updated)
        }
        self.adventurerTableView.reloadData()
    }
    
    //MARK: Navigation
    //Navigating between the different views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddAdventurer":
                os_log("Adding a new adventurer", log: OSLog.default, type: .debug)
            
            case "Quest":
                guard let QuestViewController = segue.destination as? QuestViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedCell = sender as? AdventurerTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                 
                guard let indexPath = adventurerTableView.indexPath(for: selectedCell) else {
                    fatalError("The selected cell is not being displayed by the table.")
                }
                
                let selectedAdventurer = adventurers[indexPath.row]
                QuestViewController.adventurer = selectedAdventurer

            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}

//MARK: UITableViewDataSource
//Displaying the adventurers in the table cells
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
