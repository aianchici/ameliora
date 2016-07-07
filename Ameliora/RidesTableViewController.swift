//
//  RideTableViewController.swift
//  Ameliora
//
//  Created by Alexander Ianchici on 2016-07-06.
//  Copyright © 2016 Ameliora. All rights reserved.
//

import UIKit
import HealthKit
 
class RidesTableViewController: UITableViewController {
    var ridesArray: [Ride]!
    let dateFormatter: NSDateFormatter = {
        let _dateFormatter = NSDateFormatter()
        _dateFormatter.dateStyle = .MediumStyle
        return _dateFormatter
    }()
    let transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8.0))
}

// MARK: - UITableViewDataSource
extension RidesTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ridesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RideCell") as! RideCell
        
        let ride = ridesArray[indexPath.row]
        cell.dateLabel.text = dateFormatter.stringFromDate(ride.timestamp)
        cell.nameLabel.text = "Some name"
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(DetailViewController) {
            let detailViewController = segue.destinationViewController as! DetailViewController
            let ride = ridesArray?[tableView.indexPathForSelectedRow!.row]
            detailViewController.ride = ride
        }
    }
}
