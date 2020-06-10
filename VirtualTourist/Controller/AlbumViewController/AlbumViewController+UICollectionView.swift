//
//  AlbumViewController+UICollectionView.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import UIKit
import AlamofireImage

extension AlbumViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        guard
            let photoCollectionViewCell = cell as? PhotoCollectionViewCell,
            let photoURL = photos[indexPath.row].url
        else { return cell }
        
        photoCollectionViewCell.photoImageView.af.setImage(withURL: photoURL, placeholderImage: UIImage(named: "Placeholder"))
        
        return photoCollectionViewCell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Photo.delete(photos[indexPath.row])
        photos.remove(at: indexPath.row)
        
        collectionView.reloadData()
    }
}
