//
//  ViewController.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/16/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var inputOdds: [UITextField] = []
    var inputOddsFloat = [Float]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    

    @IBAction func assistButtonPressed(_ sender: UIButton) {
        //Assign odds from input fields

        for index in 0..<inputOdds.count {
            if let odd = inputOdds[index].text {
                inputOddsFloat.append(Float(odd) ?? 0)
            }
        }
        
        if inputOddsFloat.contains(0.0) {
            //Throw UIAlarm da nisu unete sve kvote!!!
        } else {
            // Poslati Float niz u SecondViewControler, proveriti show segue da li je potreban ili je dovoljna funkcija prepare(...)
        }
        
        print(inputOddsFloat)
    }
    
 
        
    //MARK: - Send data to SecondviewController via Segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "assistSegue" {
//            let destinationVC = segue.destination as! SecondViewController
//            //print(dog1.odds)
//            destinationVC.textTest = "testiranje" //String(dog1.odds)
//            print("oooooooooooooo")
//        }
//    }


    
}

