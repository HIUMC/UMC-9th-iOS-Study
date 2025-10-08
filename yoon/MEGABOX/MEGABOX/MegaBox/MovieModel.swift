//
//  HomeModel.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI

struct MovieModel: Identifiable, Hashable {
    let id = UUID()
    var posterName: String
    let secPosterName: String
    let name: String
    let engname: String
    let performance: String
    let age: String
}
// 이미지, 버튼 View 라서 모델에 넣는 것 비추
// 연관값인 MovieModel에도 Hashable 넣어주기
