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

    let managedObjectContext: NSManagedObjectContext = GTManagedObjectContext.mainContext
    var routes: Route[]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackendClient.instance.getRoutesListOnCompletion({ (routes: Route[]?, error: NSError?) -> () in
            if routes {
                self.routes = routes
                self.tableView.reloadData()
//                NSLog("%@", routes.description)
            }
            else {
                NSLog("%@", error.description)
            }
        })

//        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
////            let indexPath = self.tableView.indexPathForSelectedRow()
////            //let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
////            (segue.destinationViewController as DetailViewController).detailItem = object
//        }
//    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let count = routes?.count {
            return count
        }
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCellInSection
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(CellId, forIndexPath: indexPath) as CustomTableViewCell
        
        let route = routes![indexPath.section]
        cell.pointsCountLabel.text = "\(route.pointsNum)"
        cell.routeNameLabel.text = "\(route.name)"
        cell.setRating(route.rating);
        var finished = route.finishedByUser as Bool
        cell.setFinished(finished)
        cell.setDifficulty(route.difficulty as Int)

//        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
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

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var mapController = segue.destinationViewController as MapViewController
        mapController.showRoute = true;
    }
}

