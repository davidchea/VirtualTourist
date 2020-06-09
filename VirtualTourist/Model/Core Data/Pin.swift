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
    
    static func add(_ location: CLLocationCoordinate2D) {
        let pin = Pin(context: DataController.shared.getContext())
        pin.latitude = location.latitude
        pin.longitude = location.longitude
        
        DataController.shared.saveContext()
    }
}
