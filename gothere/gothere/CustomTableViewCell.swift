//
//  CustomTableViewCell.swift
//  TestTBSwift
//
//  Created by Stepan Trofimov on 28.06.14.
//  Copyright (c) 2014 Stepan Trofimov. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var routeNameLabel: UILabel
    @IBOutlet var finishedByUserLabel: UILabel
    @IBOutlet var pointsCountLabel: UILabel
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // Initialization code
    }

}
