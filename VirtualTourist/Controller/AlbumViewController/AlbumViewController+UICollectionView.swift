//
//  AlbumViewController+UICollectionView.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import UIKit
import AlamofireImage

extension AlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        guard let photoCollectionViewCell = cell as? PhotoCollectionViewCell else { return cell }
        
        photoCollectionViewCell.photoImageView.af.setImage(withURL: photoURLs[indexPath.row])
        
        return photoCollectionViewCell
    }
}
