//
//  QuestViewController.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/22/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit
import CoreData

class QuestViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var qName: UILabel!
    @IBOutlet weak var qLevel: UILabel!
    @IBOutlet weak var qClass: UILabel!
    @IBOutlet weak var qAttack: UILabel!
    @IBOutlet weak var qHP: UILabel!
    @IBOutlet weak var qImage: UIImageView!
    @IBOutlet weak var questLog: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func endQuest(_ sender: UIButton) {
    }
}
