//
//  SearchFormViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/5.
//

import Foundation
import Alamofire

class BusinessViewModel: ObservableObject {
    @Published var isSubmitButtonClicked = false
    @Published var isBusinessSearched = false
    @Published var businessesData = [Business]()
    
    func SearchBusinesses(
        keyword: String,
        latitude: String,
        longitude:String,
        distance: String,
        category: String
    ) async throws {
        let replacedCategory = category.replacingOccurrences(of: " ", with: "%20")
        let url = "\(SERVER_ADDRESS)/businesses?keyword=\(keyword)&latitude=\(latitude)&longitude=\(longitude)&distance=\(distance)&category=\(replacedCategory)"
        let response = await AF.request(url).serializingDecodable([Business].self).response
        guard let businesses = response.value else{return}
        if businesses[0].index != -1 {
            self.businessesData = businesses
        } else {
            self.businessesData = [Business]()
        }
    }
}

