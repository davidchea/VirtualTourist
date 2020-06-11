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
    
    var pin: Pin?
    
    var photos: [Photo] = []
    var pages = 1
    
    let nbPhotosDisplayed = 10
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPointAnnotation()
        setCollection()
    }
    
    // MARK: - Action
    
    @IBAction func setNewCollection() {
        photos.forEach { Photo.delete($0) }
        photos.removeAll()
        
        collectionView.reloadData()
        
        setPhotos(nbPhotosDisplayed)
    }
    
    // MARK: - Private methods
    
    /// Add a pin to the map and zoom on the location.
    private func setPointAnnotation() {
        guard let pin = pin else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = pin.coordinate
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: pointAnnotation.coordinate, latitudinalMeters: 500000, longitudinalMeters: 500000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func setCollection() {
        guard
            let pin = pin,
            let photosSet = pin.photos,
            let photosArray = Array(photosSet) as? [Photo]
        else { return }
        
        photos = photosArray
        
        if photos.count < nbPhotosDisplayed {
            setPhotos(nbPhotosDisplayed - photos.count)
        }
    }
    
    private func setPhotos(_ perPage: Int) {
        guard let pin = pin else { return }
        
        newCollectionButton.isEnabled = false
        activityIndicatorView.startAnimating()
        
        FlickrAPI.shared.getAlbumByCoordinate(coordinate: pin.coordinate, perPage: perPage, pages: pages) { albumCodable in
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
}
