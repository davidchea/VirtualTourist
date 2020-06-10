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
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var coordinate: CLLocationCoordinate2D?
    var photoURLs: [URL] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPointAnnotation()
        setPhotos()
    }
    
    // MARK: - Private methods
    
    /// Add a pin to the map and zoom on the location.
    private func setPointAnnotation() {
        guard let coordinate = coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setPhotos() {
        guard let coordinate = coordinate else { return }
        
        FlickrAPI.shared.getAlbumByCoordinate(coordinate: coordinate) { albumCodable in
            guard let albumCodable = albumCodable else { return }
            
            for photo in albumCodable.photos.photo {
                if let photoURL = FlickrAPI.shared.getPhotoURL(farm: photo.farm, server: photo.server, id: photo.id, secret: photo.secret) {
                    self.photoURLs.append(photoURL)
                }
            }
            
            self.collectionView.reloadData()
        }
    }
}
