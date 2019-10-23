//
//  adventurer.swift
//  group18_Assignment 6
//
//  Created by Xia, Emily on 10/22/19.
//  Copyright © 2019 Group 18. All rights reserved.
//

import UIKit

class adventurer {
    let name: String
    let adClass: String
    let image: UIImage
    let level: Int
    let currentHP: Int
    let totalHP: Int
    let attack: Float
    
    //MARK: Initialization
    init(name: String, adClass: String , image: UIImage, level: Int, currentHP: Int, totalHP: Int, attack: Float) {

        self.name = name
        self.adClass = adClass
        self.image = image
        self.level = level
        self.currentHP = currentHP
        self.totalHP = totalHP
        self.attack = attack
        
    }
    
}
