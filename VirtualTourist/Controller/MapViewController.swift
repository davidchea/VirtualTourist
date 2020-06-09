//
//  MapViewController.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    @IBAction func dropPin(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        guard longPressGestureRecognizer.state == .began else { return }
        
        let touchPoint = longPressGestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        mapView.addAnnotation(annotation)
        
        Pin.set(location: touchMapCoordinate)
    }
}
