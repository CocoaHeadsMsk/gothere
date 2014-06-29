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
    @IBOutlet var rating1star: UIImageView
    @IBOutlet var rating2star: UIImageView
    @IBOutlet var rating3star: UIImageView
    @IBOutlet var rating4star: UIImageView
    @IBOutlet var rating5star: UIImageView
    @IBOutlet var completionMark: UIImageView
    @IBOutlet var difficultyImage: UIImageView
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // Initialization code
    }
    
    func setRating(rating: String) {
        var rate: Int = rating.utf16count;
        rating5star.hidden = rate < 5
        rating4star.hidden = rate < 4
        rating3star.hidden = rate < 3
        rating2star.hidden = rate < 2
        rating1star.hidden = rate < 1
    }
    
    func setFinished(finished: Bool) {
        completionMark.highlighted = finished
        if (finished) {
            finishedByUserLabel.text = "Завершено"
        } else {
            finishedByUserLabel.text = "Не завершено"
        }
    }

    func setDifficulty(diff: Int) {
        if (diff < 2) {
            difficultyImage.image = UIImage(named:"difficulty1")
        } else {
            if (diff > 2) {
                difficultyImage.image = UIImage(named:"difficulty3")
            } else {
                difficultyImage.image = UIImage(named:"difficulty2")
            }
        }
    }
}
