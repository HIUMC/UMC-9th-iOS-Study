//
//  MovieModel.swift
//  MovieApp
//
//  Created by 이서현 on 9/21/25.
//

import Foundation
import SwiftUI

struct MovieModel {
    let movieImage: Image /* 영화 포스터 이미지 */
    let movieName: String /* 영화 이름 */
    let movieLike: Int /* 영화 좋아요 */
    let movieReserCount: Double /* 영화 예매율 */
}
