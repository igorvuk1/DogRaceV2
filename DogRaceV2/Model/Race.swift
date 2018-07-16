//
//  Race.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/16/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import Foundation
import RealmSwift

class Race: Object {
    
    @objc dynamic var id : Int = 0
    
    @objc dynamic var dog1 : Dog? = nil
    @objc dynamic var dog2 : Dog? = nil
    @objc dynamic var dog3 : Dog? = nil
    @objc dynamic var dog4 : Dog? = nil
    @objc dynamic var dog5 : Dog? = nil
    @objc dynamic var dog6 : Dog? = nil
    
//    init(dog1: Dog, dog2: Dog, dog3: Dog, dog4: Dog, dog5: Dog, dog6: Dog) {
//
//        self.dog1 = dog1
//        self.dog2 = dog2
//        self.dog3 = dog3
//        self.dog4 = dog4
//        self.dog5 = dog5
//        self.dog6 = dog6
//    }
    
}
