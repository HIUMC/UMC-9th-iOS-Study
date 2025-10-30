//
//  TopDomainModel.swift
//  UMC_Megabox
//
//  Created by 이한결 on 10/27/25.
//

import Foundation

struct TopDomainModel {
    let status: String
    let msg: String
    let data: MoviesDomainModel
}

extension TopDomainModel {
    func toDTO() -> APIResponse {
        return APIResponse(
            status: status,
            msg: msg,
            data: data.toDTO()
        )
    }
}
