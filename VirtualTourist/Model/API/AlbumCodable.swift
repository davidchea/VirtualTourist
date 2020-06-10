//
//  AlbumCodable.swift
//  VirtualTourist
//
//  Created by David Chea on 10/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

// MARK: - AlbumCodable

struct AlbumCodable: Codable {
    
    let photos: Photos
    let stat: String
}

// MARK: - Photos

struct Photos: Codable {
    
    let page, pages, perpage: Int
    let total: String
    let photo: [PhotoCodable]
}

// MARK: - Photo

struct PhotoCodable: Codable {
    
    let id, owner, secret, server, title: String
    let ispublic, isfriend, isfamily, farm: Int
}
