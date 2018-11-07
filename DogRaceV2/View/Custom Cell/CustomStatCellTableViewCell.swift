//
//  CustomStatCellTableViewCell.swift
//  DogRaceV2
//
//  Created by Igor Vukosavljevic on 9/14/18.
//  Copyright © 2018 Igor Vukosavljevic. All rights reserved.
//

import UIKit

class CustomStatCellTableViewCell: UITableViewCell {

    //Add outlets from nib file
    //Image View
    @IBOutlet weak var orderNumber: UIImageView!
    //Labels
    @IBOutlet weak var firstPositionPercent: UILabel!
    @IBOutlet weak var secondPositionPercent: UILabel!
    @IBOutlet weak var thirdPositionPercent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
