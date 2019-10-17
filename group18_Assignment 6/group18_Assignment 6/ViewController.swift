//
//  ViewController.swift
//  group18_Assignment 6
//
//  Created by Group 18 on 10/17/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var adventurerTableView: UITableView!
    
    var adventurers: [NSManagedObject] = []
    
    //MARK:Methods
    func save(name: String) {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
      let person = NSManagedObject(entity: entity, insertInto: managedContext)

      person.setValue(name, forKeyPath: "name")

      do {
        try managedContext.save()
        adventurers.append(person)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
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
    //Add Member Action
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return adventurers.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let adventurer = adventurers[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = adventurer.value(forKeyPath: "name") as? String
    return cell
  }
}

