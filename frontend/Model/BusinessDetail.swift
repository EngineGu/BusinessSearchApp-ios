//
//  File.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import Foundation

struct BusinessDetail: Hashable, Codable, Identifiable {
    var id: String = ""
    var name: String = ""
    var status: String = ""
    var category: String = ""
    var address: String = ""
    var coordinates: Coordinates = Coordinates()
    var phoneNumber: String = ""
    var price: String = ""
    var moreInfoLink: String = ""
    var photoLinks: [String] = [""]
    var twitterLink: String = ""
    var facebookLink: String = ""
}

struct Coordinates: Hashable, Codable {
    var latitude: String = ""
    var longitude: String = ""
}


