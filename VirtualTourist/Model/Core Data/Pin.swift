//
//  Pin.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import MapKit
import CoreData

extension Pin: MKAnnotation {
    
    // MARK: - Computed property
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: latitude) ?? 0, longitude: CLLocationDegrees(exactly: longitude) ?? 0)
    }
    
    // MARK: - Static methods
    
    static func getAll() -> [Pin] {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        do {
            return try DataController.shared.getContext().fetch(fetchRequest) as [Pin]
        } catch {
            debugPrint("\(#function) - \(error)")
        }
        
        return []
    }
    
    /// Return the pin that matches the latitude and the longitude in Core Data.
    static func get(_ coordinate: CLLocationCoordinate2D) -> Pin? {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        do {
            let pins = try DataController.shared.getContext().fetch(fetchRequest) as NSArray
            let predicate = NSPredicate(format: "latitude = %@ && longitude = %@", argumentArray: [coordinate.latitude, coordinate.longitude])
            
            return pins.filtered(using: predicate).first as? Pin
        } catch {
            debugPrint("\(#function) - \(error)")
        }
        
        return nil
    }
    
    static func add(_ coordinate: CLLocationCoordinate2D) {
        let pin = Pin(context: DataController.shared.getContext())
        pin.latitude = coordinate.latitude
        pin.longitude = coordinate.longitude
        
        DataController.shared.saveContext()
    }
}
