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
    var dogs = List<Dog>()
 
}

//MARK: - Calculate IN and OUT centroid for list of races

func calculateCentroid(races : [Race]) -> (Float, Float) {
    //Read data from Realm
    //Code here
    var inThree : Float = 0.0
    var outThree : Float = 0.0

    for race in races {
        for dog in race.dogs {
            if dog.position <= 3 {
                inThree += dog.odds
            } else {
                outThree += dog.odds
            }
        }
    }
    
    inThree /= (Float(races.count) * 3.0)
    outThree /= (Float(races.count) * 3.0)
    return (inThree, outThree)
}

//MARK: - Analys race method according positions in order to centroids

func analys(race:Race, inCentroid: Float, outCentroid: Float) -> [[Int]] {
    //Calculate distance between INCentroid and kvota, on the left are positive, on the right are negative
    var inDistance = [Dog]()
    var outDistance = [Dog]()
    
    var finalResultIn = [Int]()
    var finalResultOut = [Int]()
    
    for dog in race.dogs {
        dog.centroidInDist = abs(inCentroid - dog.odds)
        dog.centroidOutDist = abs(outCentroid - dog.odds)
        inDistance.append(dog)
        outDistance.append(dog)
    }
    
    inDistance = inDistance.sorted(by: {$0.centroidInDist < $1.centroidInDist})
    outDistance = outDistance.sorted(by: {$0.centroidOutDist < $1.centroidOutDist})
    
    for dog in inDistance {
        finalResultIn.append(dog.number)
    }
    
    for dog in outDistance {
        finalResultOut.append(dog.number)
    }

    return [finalResultIn, finalResultOut]
    
}


