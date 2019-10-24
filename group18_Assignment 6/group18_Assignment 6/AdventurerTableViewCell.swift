//
//  AdventurerTableViewCell.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/21/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit

class AdventurerTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var adLevel: UILabel!
    @IBOutlet weak var adProfession: UILabel!
    @IBOutlet weak var adAttack: UILabel!
    @IBOutlet weak var adHP: UILabel!
    @IBOutlet weak var adImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
