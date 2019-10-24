//
//  QuestViewController.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/22/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData
import os.log

class QuestViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var qName: UILabel!
    @IBOutlet weak var qLevel: UILabel!
    @IBOutlet weak var qClass: UILabel!
    @IBOutlet weak var qAttack: UILabel!
    @IBOutlet weak var qHP: UILabel!
    @IBOutlet weak var qImage: UIImageView!
    @IBOutlet weak var questLog: UITextView!
    @IBOutlet weak var endQuest: UIButton!
    
    var adventurer = NSManagedObject()
    
    //MARK: Methods
    //Loading the screen
    override func viewDidLoad() {
        super.viewDidLoad()

        qName?.text = adventurer.value(forKeyPath: "name") as? String
        qLevel?.text = "\(adventurer.value(forKeyPath: "level") as? Int ?? 0)"
        qClass?.text = adventurer.value(forKeyPath: "adventurerClass") as? String
        let attackFl = adventurer.value(forKeyPath: "attack") as? Float
        qAttack?.text = String(format: "%.2f", attackFl ?? 0)
        let currentHPStatus = adventurer.value(forKeyPath: "currentHP") as? Int
        let totalHPStatus = adventurer.value(forKeyPath: "totalHP") as? Int
        qHP?.text = "\(currentHPStatus ?? 0)"+"/"+"\(totalHPStatus ?? 0)"
        qImage?.image = adventurer.value(forKeyPath: "image") as? UIImage
    }
    
    //Quest Dialogue
    //Quest Timers
    //Updating the info at the top according to quest (change level, currentHP)
        //Make sure this saves to core data
        //Also make sure that when the person returns to the main screen (the table view) that the current HP returns to total HP (regaining their HP) AND that the new level is updated
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the end quest button is pressed
        guard let button = sender as? UIButton, button === endQuest else {
            os_log("The End Quest button was not pressed, cancelling quest and progress", log: OSLog.default, type: .debug)
            return
        }
    }
}
