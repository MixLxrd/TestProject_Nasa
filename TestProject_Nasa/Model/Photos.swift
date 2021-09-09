//
//  Photos.swift
//  TestProject_Nasa
//
//  Created by Mike on 09.09.2021.
//

import Foundation

/*
struct Photos: Codable {
    let photos: [Photo]
}
*/

struct Photo: Codable {
    let imgSrc: String
    
    enum CodingKeys: String, CodingKey {
        case imgSrc = "img_src"
    }
}
