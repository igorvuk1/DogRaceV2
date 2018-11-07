//
//  StatTableViewController.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 9/13/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit
import RealmSwift

class StatTableViewController: UITableViewController {

    //TableView outlet
    @IBOutlet var statTableView: UITableView!
    //Loaded races
    var racesStat : Results<Race>? = globalRaces

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate and Data Source
        statTableView.delegate = self
        statTableView.dataSource = self
        
        //Configure cells and separators features
        configureTableView()
        
        //Register .xib file
        statTableView.register(UINib(nibName: "CustomStatCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        

                
        //Navigation Bar disable Back button
        self.navigationItem.setHidesBackButton(false, animated: false)
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (statTableView.frame.height - ((self.navigationController?.navigationBar.frame.height)! + 20.0)) / 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomStatCellTableViewCell
        
        //napraviti funkciju za racunanje %, treba prvo ucitati sev trke iz Realma sa load()
        cell.firstPositionPercent.text = "1: \(calculatePercent(number: indexPath.row + 1, position: 1)) %"
        cell.secondPositionPercent.text = "2: \(calculatePercent(number: indexPath.row + 1, position: 2)) %"
        cell.thirdPositionPercent.text = "3: \(calculatePercent(number: indexPath.row + 1, position: 3)) %"
        cell.orderNumber.image = UIImage(named: "\(indexPath.row + 1).jpg")
        return cell
    }
    
    // MARK: - Configure Table View Method
    
    func configureTableView() {
        
        //statTableView.rowHeight = 150.0
        //statTableView.estimatedRowHeight = UITableViewAutomaticDimension
        statTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
    }
    
    //MARK: - Calculate percent for each dog and certain position
    func calculatePercent(number: Int, position: Int) -> Float {
        var countedDogPosition = 0
        var finalPercent : Float = 0.0
        if let totalRaces = racesStat {
            for race in totalRaces {
                for dog in race.dogs {
                    if dog.number == number && dog.position == position {
                        countedDogPosition += 1
                    }
                }
            }
            finalPercent = (Float(countedDogPosition) / Float(totalRaces.count)) * 100.0
        }
        
        return finalPercent
    }
    
}


