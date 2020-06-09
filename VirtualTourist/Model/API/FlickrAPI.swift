//
//  FlickrAPI.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import MapKit
import Alamofire

struct FlickrAPI {
    
    // MARK: - Properties
    
    static var shared = FlickrAPI()
    
    var base = "https://www.flickr.com/services/rest/"
    var parameters: [String: Any] = [
        "api_key": "0ea29fcaa19df2add5182abad5100aea",
        "format": "json",
        "nojsoncallback": 1,
        "per_page": 10
    ]
    
    // MARK: - Public method
    
    func getPhotosByCoordinate(coordinate: CLLocationCoordinate2D, completionHandler: @escaping () -> Void ) {
        
        AF.request(base, parameters: parameters)
    }
}
