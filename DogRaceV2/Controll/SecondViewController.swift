//
//  SecondViewController.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/18/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    let realm = try! Realm()
    var races : Results<Race>? = nil
    var inputOdds = [Float]()
    
    @IBOutlet weak var odds1: UILabel!
    var textTest = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Second")
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //MARK: - Test calculateCentroid and analys methods
        
        let testRace1 = Race()
        let testRace2 = Race()
        
        let dog1 = Dog()
        let dog2 = Dog()
        let dog3 = Dog()
        let dog4 = Dog()
        let dog5 = Dog()
        let dog6 = Dog()
        
        
        dog1.number = 1
        dog1.odds = 4.8
        dog1.position = 6
        
        dog2.number = 2
        dog2.odds = 5.95
        dog2.position = 5
        
        dog3.number = 3
        dog3.odds = 5.55
        dog3.position = 4
        
        dog4.number = 4
        dog4.odds = 30.0
        dog4.position = 3
        
        dog5.number = 5
        dog5.odds = 8.8
        dog5.position = 2
        
        dog6.number = 6
        dog6.odds = 3.00
        dog6.position = 1
        
        testRace1.id = 777
        testRace1.dogs.append(dog1)
        testRace1.dogs.append(dog2)
        testRace1.dogs.append(dog3)
        testRace1.dogs.append(dog4)
        testRace1.dogs.append(dog5)
        testRace1.dogs.append(dog6)
        
        testRace2.id = 999
        testRace2.dogs.append(dog1)
        testRace2.dogs.append(dog2)
        testRace2.dogs.append(dog3)
        testRace2.dogs.append(dog4)
        testRace2.dogs.append(dog5)
        testRace2.dogs.append(dog6)
        
        let racesArray = [testRace1,testRace2]
        
        let result = calculateCentroid(races: racesArray)
        print(result)
        let analysed = analys(race: testRace1, inCentroid: result.0, outCentroid: result.1)
        print(analysed)
        
        ///////////////////////////////////////////////////
        //createRace()
        //load()
        odds1.text = textTest
    }

    //MARK: - Realm example Methods
    
    //SAVE and UPDATE Methods
    
    func save(race: Race) {
        do {
            try realm.write {
                realm.add(race)
            }
        } catch {
            print("Error during saving data : \(error)")
        }
    }
    
    //LOAD Method
    
    func load() {
        races = realm.objects(Race.self)
        print(races)
    }
    
    //DELETE Method
    
    func delete(race: Race) {
        do {
            try realm.write {
                realm.delete(race)
            }
        } catch {
            print("Error during deleting real : \(error)")
        }
    }
    
    func createRace(){
        let race = Race()
        
        let dog1 = Dog()
        let dog2 = Dog()
        let dog3 = Dog()
        let dog4 = Dog()
        let dog5 = Dog()
        let dog6 = Dog()
        
        race.id = 333
        race.dogs.append(dog1)
        race.dogs.append(dog2)
        race.dogs.append(dog3)
        race.dogs.append(dog4)
        race.dogs.append(dog5)
        race.dogs.append(dog6)
        
        //TODO: - Assign odds from input fields
        //            for index in 0...inputOdds.count - 1 {
        //                if let odd = inputOdds[index].text {
        //                    race.dogs[index].odds = Float(odd)!
        //                } else {
        //                    //Throw UIAlarm da nisu unete sve kvote
        //                }
        //            }
        
        dog1.number = 1
        dog1.position = 6
        
        dog2.number = 2
        dog2.position = 5
        
        dog3.number = 3
        dog3.position = 4
        
        dog4.number = 4
        dog4.position = 3
        
        dog5.number = 5
        dog5.position = 2
        
        dog6.number = 6
        dog6.position = 1
        
        save(race: race)
        
    }

}
