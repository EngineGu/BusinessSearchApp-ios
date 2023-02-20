//
//  Business.swift
//  YelpApp
//
//  Created by EngineGu on 2022/12/5.
//

import Foundation

struct Business: Hashable, Codable, Identifiable {
    var index: Int
    var id: String
    var imageUrl: String
    var name: String
    var rating: Float
    var distance: Float
}

enum SearchCategory : String, CaseIterable,Identifiable {
    case Default = "Default"
    case Arts = "Arts and Entertainment"
    case Health = "Health and Medical"
    case Hotel = "Hotels and Travel"
    case Food = "Food"
    case Professional = "Professional Services"

    var id: Self { self }
}
