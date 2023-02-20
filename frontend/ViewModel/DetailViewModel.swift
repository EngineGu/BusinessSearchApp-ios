//
//  DetailViewModel.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import Foundation
import Alamofire

class DetailViewModel: ObservableObject {
    @Published var detailData = BusinessDetail()
    
    func SearchDetail(id: String) async throws {
        let url = "\(SERVER_ADDRESS)/businesses/\(id)"
        let response = await AF.request(url).serializingDecodable(BusinessDetail.self).response
        guard let businessDetail = response.value else{return}
        self.detailData = businessDetail
    }
}
