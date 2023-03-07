//
//  MarsData.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation
import SwiftUI

struct MarsPhoto: Decodable {
    
    let id: Int
    let sol: Int
    let camera: Camera
    let img_src: String
    let earth_date: String
    let rover: Rover
    
    struct Camera: Decodable {
        let id: Int
        let name: String
        let rover_id: Int
        let full_name: String
    }
    
    struct Rover: Decodable {
        let id: Int
        let name: String
        let landing_date: String
        let launch_date: String
        let status: String
    }
}

struct PhotosResponse: Decodable {
    let photos: [MarsPhoto]
}
