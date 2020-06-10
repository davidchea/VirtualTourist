//
//  FlickrAPI.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import MapKit
import Alamofire

class FlickrAPI {
    
    // MARK: - Properties
    
    static var shared = FlickrAPI()
    
    var base = "https://www.flickr.com/services/rest/"
    var parameters: [String: Any] = [
        "api_key": "0ea29fcaa19df2add5182abad5100aea",
        "format": "json",
        "nojsoncallback": 1
    ]
    
    // MARK: - Public methods
    
    func getAlbumByCoordinate(coordinate: CLLocationCoordinate2D, pages: Int, completionHandler: @escaping (AlbumCodable?) -> Void ) {
        parameters["method"] = "flickr.photos.search"
        parameters["lat"] = coordinate.latitude
        parameters["lon"] = coordinate.longitude
        parameters["per_page"] = 15
        
        let randomPage = Int.random(in: 1...pages)
        parameters["page"] = randomPage
        
        AF.request(base, parameters: parameters).responseJSON { dataResponse in
            var albumCodable: AlbumCodable?
            if let data = dataResponse.data {
                do {
                    albumCodable = try JSONDecoder().decode(AlbumCodable.self, from: data)
                } catch {
                    debugPrint("\(#function) - \(error)")
                }
            }
            
            completionHandler(albumCodable)
        }
    }
    
    func getPhotoURL(farm: Int, server: String, id: String, secret: String) -> URL? {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).png")
    }
}
