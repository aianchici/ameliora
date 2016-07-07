//
//  MulticolourPolylineSegment.swift
//  Ameliora
//
//  Created by Alexander Ianchici on 2016-07-01.
//  Copyright © 2016 Ameliora. All rights reserved.
//

import UIKit
import MapKit

class MulticolourPolylineSegment: MKPolyline {
    var color: UIColor?

    private class func allSpeeds(forLocations locations: [Location]) ->
        (speeds: [Double], minSpeed: Double, maxSpeed: Double) {
            // Make Array of all speeds. Find slowest and fastest
            var speeds = [Double]()
            var minSpeed = DBL_MAX
            var maxSpeed = 0.0
            
            for i in 1..<locations.count {
                let l1 = locations[i-1]
                let l2 = locations[i]
                
                let cl1 = CLLocation(latitude: l1.latitude.doubleValue, longitude: l1.longitude.doubleValue)
                let cl2 = CLLocation(latitude: l2.latitude.doubleValue, longitude: l2.longitude.doubleValue)
                
                let distance = cl2.distanceFromLocation(cl1)
                let time = l2.timestamp.timeIntervalSinceDate(l1.timestamp)
                let speed = distance/time
                
                minSpeed = min(minSpeed, speed)
                maxSpeed = max(maxSpeed, speed)
                
                speeds.append(speed)
            }
            
            return (speeds, minSpeed, maxSpeed)
    }
    
    class func colorSegments(forLocations locations: [Location]) -> [MulticolourPolylineSegment] {
        let colorSegments = [MulticolourPolylineSegment]()
        
        // RGB for Red (slowest)
        let red   = (r: 1.0, g: 20.0 / 255.0, b: 44.0 / 255.0)
        
        // RGB for Yellow (middle)
        let yellow = (r: 1.0, g: 215.0 / 255.0, b: 0.0)
        
        // RGB for Green (fastest)
        let green  = (r: 0.0, g: 146.0 / 255.0, b: 78.0 / 255.0)
        
        let (speeds, minSpeed, maxSpeed) = allSpeeds(forLocations: locations)
        
        // now knowing the slowest+fastest, we can get mean too
        let meanSpeed = (minSpeed + maxSpeed)/2
        
        return colorSegments
    }
}