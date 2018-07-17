//
//  Dog.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/16/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    
    @objc dynamic var number : Int = 0
    @objc dynamic var odds : Float = 0.0
    @objc dynamic var position : Int = 0
    @objc dynamic var centroidInDist : Float = 0
    @objc dynamic var centroidOutDist : Float = 0
    var parentRace = LinkingObjects(fromType: Race.self, property: "dogs")
    
}
