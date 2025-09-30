//
//  HomeModel.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI

struct MovieModel: Identifiable {
    let id = UUID()
    let posterName: String
    let secPosterName: String
    let name: String
    let engname: String
    let performance: String
}
// 이미지, 버튼 View 라서 모델에 넣는 것 비추
