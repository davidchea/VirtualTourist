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
    @IBOutlet weak var newCollectionButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var coordinate: CLLocationCoordinate2D?
    
    var photos: [Photo] = []
    var pages = 1
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPointAnnotation()
        setNewCollection()
    }
    
    // MARK: - Action
    
    @IBAction func setNewCollection() {
        guard let coordinate = coordinate, let pin = Pin.get(coordinate) else { return }
        
        newCollectionButton.isEnabled = false
        activityIndicatorView.startAnimating()
        
        photos.removeAll()
        collectionView.reloadData()
        
        FlickrAPI.shared.getAlbumByCoordinate(coordinate: coordinate, pages: pages) { albumCodable in
            guard let albumCodable = albumCodable else { return }
            
            for photo in albumCodable.photos.photo {
                if let photoURL = FlickrAPI.shared.getPhotoURL(farm: photo.farm, server: photo.server, id: photo.id, secret: photo.secret) {
                    let photo = Photo.add(photoURL, pin: pin)
                    self.photos.append(photo)
                }
            }
            
            self.pages = albumCodable.photos.pages
            
            self.collectionView.reloadData()
            self.newCollectionButton.isEnabled = true
            self.activityIndicatorView.stopAnimating()
        }
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
