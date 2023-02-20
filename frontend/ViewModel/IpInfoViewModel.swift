//
//  IpInfoViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/6.
//

import Foundation
import Alamofire

class IpInfoViewModel: ObservableObject {
    
    func AutoGetLocation() async throws -> (latitude:String,longitude:String) {
        let url = "https://ipinfo.io/?token=\(MY_IPINFO_API_TOKEN)"
        let response = await AF.request(url).serializingDecodable(IpInfo.self).response
        guard let ipInfoData = response.value else{return("","")}
        let coordinatesString = ipInfoData.loc
        let coordinatesArray = coordinatesString.components(separatedBy: ",")
        let latitude = coordinatesArray[0]
        let longitude = coordinatesArray[1]
        return (latitude,longitude)
    }
}
