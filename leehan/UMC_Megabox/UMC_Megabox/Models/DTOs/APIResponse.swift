//
//  APIResponse.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let msg: String
    let data: MoviesDTO
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case msg = "message"
        case data = "data"
    }
}

extension APIResponse {
    func toDomain() -> TopDomainModel {
        return TopDomainModel(
            status: status,
            msg: msg,
            data: data.toDomain()
        )
    }
}
