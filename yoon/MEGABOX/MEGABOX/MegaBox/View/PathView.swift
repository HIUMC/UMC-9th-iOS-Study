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
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var loginVM: LoginViewModel
    @Environment(MovieViewModel.self) var viewModel
    @EnvironmentObject var theaterVM: TheaterViewModel
    @Binding var selectTheaters: Set<Theaters>
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.path) {
            MBTabView(theaterVM: theaterVM, selectTheaters: $selectTheaters)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        MBTabView(theaterVM: theaterVM, selectTheaters: $selectTheaters)
                            .navigationBarBackButtonHidden(true)
                    case .detail(let movie):
                        MovieInfoView(movie: movie)
                            .navigationBarBackButtonHidden(true)
                    case .login:
                        LoginView()
                            .navigationBarBackButtonHidden(true)
                    case .profile:
                        UserInfoView()
                            .navigationBarBackButtonHidden(true)
                    case .userSetting:
                        UserSettingsView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

struct PathView_Preview: PreviewProvider {
    static var previews: some View {
        @State var selectedTheaters: Set<Theaters> = [.gangnam]
        let theaterVM = TheaterViewModel()
        
        devicePreviews {
            PathView( selectTheaters: $selectedTheaters )
                .environmentObject(theaterVM)
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
