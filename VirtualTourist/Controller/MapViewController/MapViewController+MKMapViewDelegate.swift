//
//  MapViewController+MKMapViewDelegate.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    // MARK: - Delegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinAnnotationView.animatesDrop = true
        
        return pinAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "AlbumSegue", sender: view.annotation?.coordinate)
    }
}
