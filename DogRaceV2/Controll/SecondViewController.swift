//
//  SecondViewController.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/18/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit
import RealmSwift

protocol CanRecive {
    func enterNewRace()
}

class SecondViewController: UIViewController {

    var delegate : CanRecive?
    let realm = try! Realm()
    var races : Results<Race>? = nil
    var inputOdds = [Float]()
    let lookUpTable = [[0, 14, 26, 22, 20, 26], [14, 0, 14, 22, 25, 15], [26, 14, 0, 19, 23, 23], [22, 22, 19, 0, 22, 24], [20, 25, 23, 22, 0, 23], [26, 15, 23, 24, 23, 0]]
    
    //Labels outlets
    @IBOutlet weak var raceIdLabel: UILabel!
    @IBOutlet weak var noAdviceLabel: UILabel!
    //Image outlets
    @IBOutlet weak var firstInThreeImage: UIImageView!
    @IBOutlet weak var secondInThreeImage: UIImageView!
    @IBOutlet weak var thirdInThreeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Second")
        self.navigationItem.setHidesBackButton(true, animated: false)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        print("Aaaaaaaaaaa \(inputOdds)")
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
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
        //print(result)
        let analysed = analys(race: testRace1, inCentroid: result.0, outCentroid: result.1)
        //print(analysed)
        
        ///////////////////////////////////////////////////
        let currentRace = createRace()
        raceType(race: currentRace)
        //load()
        
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
    
    //MARK: - Create Race method
    
    func createRace() -> Race{
        let race = Race()
        //Generate random race id (NOT UNIQUE!)
        race.id = Int(arc4random_uniform(UInt32(365000)))
        raceIdLabel.text = String(race.id)

        //Append odds and number to dogs
        for index in 0...5 {
            let dog = Dog()
            
            dog.number = index + 1
            dog.odds = inputOdds[index]
            race.dogs.append(dog)
        }
        print(race.dogs)
        
//        save(race: race)
        return race
    }
    
    //MARK: - Check Race type method
    
    func raceType(race: Race) {
        var greenOdds : Int = 0
        var orangeOdds : Int = 0
        var redOdds : Int = 0
        
        for dog in race.dogs {
            if dog.odds <= 7.0 {
                greenOdds += 1
            } else if dog.odds > 7 && dog.odds <= 10 {
                orangeOdds += 1
            } else {
                redOdds += 1
            }
        }
        print("---------------------------")
        print(greenOdds, orangeOdds, redOdds)
        //if (greenOdds == 4 && orangeOdds == 1 && redOdds == 1) || (greenOdds == 3 && orangeOdds == 2 && redOdds == 1) {
            print("PREDICT")
            let dogsSortedByOdds = sortedByOdds(race: race)
            //print(dogsSortedByOdds)
            predictRace(dogs: dogsSortedByOdds)
            
        //} else {
            //noAdviceLabel.text = "Sorry, no advice."
        //}
        
    }
    
    //MARK: - DONE Button Pressed
    
    @IBAction func donePressed(_ sender: UIButton) {
        delegate?.enterNewRace()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
   //MARK: - Predict race result method
    
    func predictRace(dogs: [Dog]) {
        // uzeti prva 4 i zatim na osnovu tabele iz excela po pozicijama izracunati biase, za 321 slucaj videti kolika je razlika izmedju 3 i 4 pa na osnovu toga uzrti 4 u razmatranje ili ne.
        
        
        var firstInThree = 0
        var secondInThree = 0
        var thirdInThree = 0
        
        var dogSets : Set<Dog> = [dogs[0]]
        var arrayOfSets : [Set<Dog>] = []
        var numberOfDogsFromSet : [Dog] = []
        
        //Cretae sets with similar odds
        
        for index in 1...5 {
            let difference  = dogs[index].odds - dogs[index - 1].odds
            
            if difference < 1.0 {
                if !dogSets.contains(dogs[index]){
                    dogSets.insert(dogs[index])
                }
                if !dogSets.contains(dogs[index - 1]) {
                    dogSets.insert(dogs[index - 1])
                }
            } else {
                arrayOfSets.append(dogSets)
                dogSets.removeAll()
                dogSets.insert(dogs[index])
            }
        }
        
        arrayOfSets.append(dogSets)
        // Take from evry set candidates, divade number of set elemts with 2 and round to upper number
        for var set in arrayOfSets {
            let dogsFromSets = Int((Float(set.count) / 2.0).rounded(.up))
            //sortirai set po kvotama
            for _ in 0..<dogsFromSets {
                if let candidate = set.first {
                    numberOfDogsFromSet.append(candidate)
                    set.remove(candidate)
                }
            }
        }
        print(numberOfDogsFromSet)
        
        firstInThree = numberOfDogsFromSet[0].number
        secondInThree = numberOfDogsFromSet[1].number
        thirdInThree = numberOfDogsFromSet[2].number
        
        //print(arrayOfSets.count)
//        firstInThree = dogs[0].number
//        // Here call lookUpTable
//        var lookUpPosition1 = lookUpTable(lookTableFor: firstInThree)
//        print("INDEX OF MAX \(lookUpPosition1)")
//        print("***********************************")
//
//        for index in 1...3 { // compare with second, third and fourth position (first 4 dogs in array)
//            if lookUpPosition1 == dogs[index].number {
//                secondInThree = dogs[index].number
//            }
//        }
//
//        if secondInThree == 0 {
//            //var lookUpPosition2 = lookUpTable(lookTableFor: <#T##Int#>)
//        }
//
//        thirdInThree = lookUpTable(lookTableFor: secondInThree)
//
//        if thirdInThree == firstInThree {
//          //  thirdInThree = kako naci vrednost niza koja je predzadnja po velicini, odmah pre max() vrednosti
//        }
        
        firstInThreeImage.image = UIImage(named: "\(firstInThree).jpg")
        secondInThreeImage.image = UIImage(named: "\(secondInThree).jpg")
        thirdInThreeImage.image = UIImage(named: "\(thirdInThree).jpg")
        
        print(firstInThree, secondInThree, thirdInThree)
    }
    
    //MARK: - Look up Table method
    
//    func lookUpTable(lookTableFor dogInThree : Int) -> Int {
//
//        var lookUpTable = [[0, 14, 26, 22, 20, 26], [14, 0, 14, 22, 25, 15], [26, 14, 0, 19, 23, 23], [22, 22, 19, 0, 22, 24], [20, 25, 23, 22, 0, 23], [26, 15, 23, 24, 23, 0]]
//
//        let positionIndex = dogInThree - 1
//        var lookUpPosition = (lookUpTable[positionIndex].index(of: lookUpTable[positionIndex].max()!) as! Int) + 1
//
//        for posArray in lookUpTable {
//            //lookUpTable[posArray][lookUpPosition - 1] = 0
//            print(posArray[lookUpPosition - 1])
//        }
//        print("//////////////////////////")
//        print(lookUpTable)
//        return lookUpPosition
//
//    }
    
}
