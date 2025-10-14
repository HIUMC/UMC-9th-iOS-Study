//
//  PathView.swift
//  week1_homework
//
//  Created by 정승윤 on 10/2/25.
//

import Foundation
import SwiftUI
// 페이지마다 case 넣고 경로 넣고 하기는 지저분해지니, 하나의 파일에 모아두기
struct PathView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var viewModel
    @ObservedObject var theaterVM: TheaterViewModel
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.path) {
            LoginView(loginInput: LoginViewModel())
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        MBTabView(theaterVM: theaterVM)
                            .navigationBarBackButtonHidden(true)
                    case .detail(let movie):
                        MovieInfoView(movie: movie)
                            .navigationBarBackButtonHidden(true)
                    case .login:
                        LoginView(loginInput:LoginViewModel())
                            .navigationBarBackButtonHidden(true)
                    case .profile:
                        UserInfoView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

struct PathView_Preview: PreviewProvider {
    static var previews: some View {
        let theaterVM = TheaterViewModel()
        devicePreviews {
            
            PathView(theaterVM : theaterVM )
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
