//
//  UserRouter.swift
//  TestMoya
//
//  Created by 정승윤 on 11/12/25.
//

import Foundation

import Foundation
import Moya
import Alamofire

enum UserRotuer {
    case getPerson(name: String)
    case postPerson(userData: UserData)
    case patchPerson(patchData: UserPatchRequest)
    case putPerson(userData: UserData)
    case deletePerson(name: String)
}

extension UserRotuer: APITargetType {
    var baseURL: URL {
           return URL(string: "http://localhost:8080")!
       }

       var headers: [String: String]? {
           switch task {
           case .requestJSONEncodable, .requestParameters:
               return ["Content-Type": "application/json"]
           case .uploadMultipart:
               return ["Content-Type": "multipart/form-data"]
           default:
               return nil
           }
       }
    
    var path: String {
        return "/person"
    }
    
    var method: Moya.Method {
        switch self {
        case .getPerson:
            return .get
        case .postPerson:
            return .post
        case .patchPerson:
            return .patch
        case .putPerson:
            return .put
        case .deletePerson:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getPerson(let name), .deletePerson(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.queryString)
        case .postPerson(let userData), .putPerson(let userData):
            return .requestJSONEncodable(userData)
        case .patchPerson(let patchData):
            return .requestJSONEncodable(patchData)
        }
    }
}
