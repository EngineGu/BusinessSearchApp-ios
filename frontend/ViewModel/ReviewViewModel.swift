//
//  ReviewViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import Foundation
import Alamofire

class ReviewViewModel: ObservableObject {
    func SearchReviews(id: String) async throws -> [Review]{
        let url = "\(SERVER_ADDRESS)/businesses/\(id)/reviews"
        let response = await AF.request(url).serializingDecodable([Review].self).response
        guard let businessReviews = response.value else{return[Review]()}
        return businessReviews
    }
}
