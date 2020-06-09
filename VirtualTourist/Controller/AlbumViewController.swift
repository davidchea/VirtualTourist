//
//  AlbumViewController.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import UIKit
import MapKit

class AlbumViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Property
    
    var coordinate: CLLocationCoordinate2D?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPointAnnotation()
    }
    
    // MARK: - Private method
    
    /// Add a pin to the map and zoom on the location.
    private func setPointAnnotation() {
        guard let coordinate = coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
