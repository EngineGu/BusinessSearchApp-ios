//
//  AutoCompleteViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import Foundation
import Alamofire

class AutoCompleteViewModel: ObservableObject {
    
    func AutoCompleteText(keyword: String) async throws -> [String] {
        let url = "\(SERVER_ADDRESS)/autocomplete?text=\(keyword)"
        let response = await AF.request(url).serializingDecodable([String].self).response
        guard let AutoCompleteTextArray = response.value else{return([""])}
        return (AutoCompleteTextArray)
    }
}

