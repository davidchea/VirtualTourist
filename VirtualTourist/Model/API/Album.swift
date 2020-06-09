//
//  Album.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

// MARK: - Album

struct Album: Codable {
    
    let photos: Photos
    let stat: String
}

// MARK: - Photos

struct Photos: Codable {
    
    let page, perpage: Int
    let pages, total: String
    let photo: [PhotoCodable]
}

// MARK: - Photo

struct PhotoCodable: Codable {
    
    let id, owner, secret, server, title: String
    let ispublic, isfriend, isfamily, farm: Int
}
