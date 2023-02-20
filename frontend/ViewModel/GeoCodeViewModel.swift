//
//  GeoCodeViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import Foundation
import Alamofire

class GeoCodeViewModel: ObservableObject {
    
    func GoogleGetLocation(location: String) async throws -> (latitude:String, longitude: String) {
        let replacedLocation = location.replacingOccurrences(of: " ", with: "%20")
        let url = "\(SERVER_ADDRESS)/geocode?address=\(replacedLocation)"
        let response = await AF.request(url).serializingDecodable(Geocode.self).response
        guard let geoCodeData = response.value else{return("","")}
        let latitude = geoCodeData.latitude
        let longitude = geoCodeData.longitude
        return (latitude,longitude)
    }
}
