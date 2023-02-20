//
//  Review.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import Foundation

struct Review: Hashable, Codable {
    var rating: Float
    var text: String
    var time_created: String
    var username: String
}
