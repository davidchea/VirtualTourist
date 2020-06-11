//
//  Photo.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import CoreData

extension Photo {
    
    // MARK: - Static methods
    
    static func add(_ photoURL: URL, pin: Pin) -> Photo {
        let photo = Photo(context: DataController.shared.getContext())
        
        do {
            let photoData = try Data(contentsOf: photoURL)
            photo.photo = photoData
        } catch {
            debugPrint("\(#function) - \(error)")
        }
        
        photo.url = photoURL
        photo.pin = pin
        
        DataController.shared.saveContext()
        
        return photo
    }
    
    static func delete(_ photo: Photo) {
        DataController.shared.getContext().delete(photo)
        DataController.shared.saveContext()
    }
}
