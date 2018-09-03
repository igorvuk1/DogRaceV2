//
//  ViewController.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 7/16/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CanRecive {



    
    @IBOutlet var inputOdds: [UITextField] = []
    var inputOddsFloat = [Float]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("First")
            
        
    }
    


    @IBAction func assistButtonPressed(_ sender: UIButton) {
        //Assign odds from input fields

        for index in 0..<inputOdds.count {
            if let odd = inputOdds[index].text {
                inputOddsFloat.append(Float(odd) ?? 0)
            }
        }
        
        if inputOddsFloat.contains(0.0) {
            
            //Throw UIAlert if some odds missing!!!
            let alert = UIAlertController(title: "Missing Odds", message: "Please enter all odds!", preferredStyle: .alert)
            let enterAllOddsAction = UIAlertAction(title: "Re-Enter", style: .cancel) { (UIAlertAction) in
                self.inputOddsFloat = []
            }
            alert.addAction(enterAllOddsAction)
            present(alert, animated: true, completion: nil)
            
            
        }
        
        print(inputOddsFloat)
    }
    
    //MARK: - Send data to SecondviewController via Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "assistSegue" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.inputOdds = inputOddsFloat
            destinationVC.delegate = self
        }
    }
    
    //MARK: - CanRecive protocol method, remove old data
    func enterNewRace() {
        
        for index in 0..<inputOdds.count {
            inputOdds[index].text = ""
        }
        
        inputOddsFloat = []
    }
}

