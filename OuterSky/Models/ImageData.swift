//
//  ImageData.swift
//  OuterSky
//
//  Created by Marco Lucio Sosa on 2/10/23.
//

import Foundation

struct Image: Decodable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
}
