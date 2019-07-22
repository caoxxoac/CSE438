//
//  myPet.swift
//  Lab2
//
//  Created by Xiangzhi Cao on 9/13/18.
//  Copyright © 2018 Xiangzhi Cao. All rights reserved.
//

import Foundation
class MyPet {
    var happiness: Int
    var petFeed: Int
    var vegeEnergy: Int
    var meatEnergy: Int
    var storage: Int
    
    init(happiness: Int, petFeed: Int) {
        self.happiness = happiness
        self.petFeed = petFeed
        self.storage = 0
        self.vegeEnergy = 15
        self.meatEnergy = 30
    }
    
    func play(){
        if (petFeed >= 20){
            petFeed -= 20
            happiness += 10
            if (happiness >= 100){
                happiness = 100
            }
        }
    }
    
    func buyVege(){
        if (self.storage < 100){
            self.storage += 1
        }
        if (self.storage >= 100) {
            self.storage = 100
        }
    }
    
    func buyMeat(){
        if (self.storage < 100){
            self.storage += 2
        }
        if (self.storage >= 100){
            self.storage = 100
        }
    }
    
    func feedVege(){
        if (self.storage > 0){
            petFeed += self.vegeEnergy
            self.storage -= 1
        }
        if (petFeed > 100){
            petFeed = 100
        }
    }
    
    func feedMeat(){
        if (self.storage > 1){
            petFeed += self.meatEnergy
            self.storage -= 2
        }
        if (petFeed > 100){
            petFeed = 100
        }
    }
    
    func reset(){
        self.happiness = 0
        self.petFeed = 0
        self.storage = 0
    }
    
}
