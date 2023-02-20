//
//  ModelData.swift
//  YelpApp
//
//  Created by EngineGu on 2022/12/5.
//

import Foundation


var sampleBusinesses: [Business] = load("businesses.json")

var sampleBusinessDetail: BusinessDetail = load("businessDetail.json")

var sampleReviews: [Review] = load("reviews.json")

let LOCAL_SERVER_ADDRESS = "http://127.0.0.1:8080"
let REMOTE_SERVER_ADDRESS = "https://cs571-hw7-366300.nn.r.appspot.com"

let  SERVER_ADDRESS = REMOTE_SERVER_ADDRESS
let  MY_IPINFO_API_TOKEN = ""

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
