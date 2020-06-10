//
//  Photo.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import CoreData

extension Photo {
    
    // MARK: - Static method
    
    static func add(_ photoURL: URL, pin: Pin) {
        let photo = Photo(context: DataController.shared.getContext())
        
        do {
            let data = try Data(contentsOf: photoURL)
            photo.photo = data
        } catch {
            debugPrint("\(#function) - \(error)")
        }
        
        photo.pin = pin
        DataController.shared.saveContext()
    }
}
