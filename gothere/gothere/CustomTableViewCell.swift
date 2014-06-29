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
        var star: UIImage = UIImage(named: "ratingStarOff")
        var starOn: UIImage = UIImage(named: "ratingStar")
        if rate > 4 {
            star = starOn
        }
        rating5star.image = star
        if rate == 4 {
            star = starOn
        }
        rating4star.image = star
        if rate == 3 {
            star = starOn
        }
        rating3star.image = star
        if rate == 2 {
            star = starOn
        }
        rating2star.image = star
        if rate == 1 {
            star = starOn
        }
        rating1star.image = star
    }
    
    func setFinished(finished: Bool) {
        if (finished) {
            finishedByUserLabel.text = "Finished"
            completionMark.image = UIImage(named:"routeCompletionSelectected")
        } else {
            finishedByUserLabel.text = "Not finished"
            completionMark.image = UIImage(named:"routeCompletion")
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
