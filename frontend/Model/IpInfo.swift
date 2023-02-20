//
//  IpInfo.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import Foundation

struct IpInfo: Hashable, Codable {
    var ip: String
    var hostname: String
    var city: String
    var region: String
    var country: String
    var loc: String
    var org: String
    var postal: String
    var timezone: String
}
