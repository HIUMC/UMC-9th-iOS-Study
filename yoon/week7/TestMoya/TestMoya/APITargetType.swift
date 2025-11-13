//
//  APITargetType.swift
//  TestMoya
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
}


