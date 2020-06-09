//
//  Pin.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import MapKit

extension Pin {
    
    static func set(location: CLLocationCoordinate2D) {
        let pin = Pin(context: DataController.shared.getContext())
        pin.setValuesForKeys([
            "latitude": location.latitude,
            "longitude": location.longitude
        ])
        
        DataController.shared.saveContext()
    }
}
