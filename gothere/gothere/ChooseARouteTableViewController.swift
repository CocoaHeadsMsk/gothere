//
//  MasterViewController.swift
//  TestTBSwift
//
//  Created by Stepan Trofimov on 28.06.14.
//  Copyright (c) 2014 Stepan Trofimov. All rights reserved.
//

import UIKit
import CoreData

class ChooseARouteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let countCellInSection = 1
    let CellId = "Cell"
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var dataSource = [
        "Difficculty": [1,2,3],
        "FinishedByUser" : [true, false, false],
        "Name" : ["Silver Trip", "Golden Trip", "GovnoTrip"],
        "Points" : [11, 0, 0],
        "Rating" : ["**", "***", "*****"]
    ]
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
////            let indexPath = self.tableView.indexPathForSelectedRow()
////            //let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
////            (segue.destinationViewController as DetailViewController).detailItem = object
//        }
//    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var count = dataSource["Points"].count
        return count;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return countCellInSection
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var difficculty : AnyObject! = dataSource["Difficculty"]
        var finishedByUser : AnyObject! = dataSource["FinishedByUser"]
        var name : AnyObject! = dataSource["Name"]
        var points : AnyObject! = dataSource["Points"]
        var ratings : AnyObject! = dataSource["Rating"]
        var rating : String = "\(ratings.objectAtIndex(indexPath.section))" // temporary asterices as a rating thing
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(CellId, forIndexPath: indexPath) as CustomTableViewCell
        
        cell.pointsCountLabel.text = "\(points.objectAtIndex(indexPath.section))"
        cell.routeNameLabel.text = "\(name.objectAtIndex(indexPath.section))"
        cell.setRating(rating);
        var finished = (finishedByUser as NSArray).objectAtIndex(indexPath.section) as Bool
        cell.setFinished(finished)
        cell.setDifficulty((difficculty as NSArray).objectAtIndex(indexPath.section) as Int)
        
        
//        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let context = self.fetchedResultsController.managedObjectContext
//            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
//                
//            var error: NSError? = nil
//            if !context.save(&error) {
//                // Replace this implementation with code to handle the error appropriately.
//                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                //println("Unresolved error \(error), \(error.userInfo)")
//                abort()
//            }
//        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
//        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
//        cell.textLabel.text = object.valueForKey("timeStamp").description
    }


}

