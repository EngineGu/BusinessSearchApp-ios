//
//  Reservation.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import Foundation

struct Reservation: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var email: String
    var date: String
    var time: String
}
