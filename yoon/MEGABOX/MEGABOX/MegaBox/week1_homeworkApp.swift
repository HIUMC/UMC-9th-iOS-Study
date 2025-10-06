//
//  week1_homeworkApp.swift
//  week1_homework
//
//  Created by 정승윤 on 9/15/25.
//

import SwiftUI

@main
struct week1_homeworkApp: App {
    var body: some Scene {
        WindowGroup {
            PathView()
                .environment(NavigationRouter())
                .environment(MovieViewModel())
// 여기에도 environment를 넣어줘야 하는구나.,.,, 깨달음 + 1
// 최상위계층에도 environment를 넣어줘야 하위 일반 뷰에서도 작동함
// 최상위를 패스뷰로 해 놔야 함. 로그인뷰로 해 놓으니까 로그인 뷰에서 넘어가질 않음 프리뷰 안넘어가는 것과 비슷한 느낌인 듯
        }
    }
}
