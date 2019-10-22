//
//  ViewController.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/17/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var adventurerTableView: UITableView!
    
    var adventurers: [NSManagedObject] = []
    
    //MARK:Methods
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
    cell.adAttack?.text = "\(adventurer.value(forKeyPath: "attack") as? Float ?? 0)"
    let currentHPStatus = adventurer.value(forKeyPath: "currentHP") as? Int
    let totalHPStatus = adventurer.value(forKeyPath: "totalHP") as? Int
    cell.adHP?.text = "\(currentHPStatus ?? 0)"+"/"+"\(totalHPStatus ?? 0)"
    
    return cell
  }
}
