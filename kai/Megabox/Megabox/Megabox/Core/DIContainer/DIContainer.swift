//
//  DiContainer.swift
//  Megabox
//
//  Created by 김지우 on 10/3/25.
//

import Foundation

//앱 전역에서 사용할 의존성 주입(Dependency Injection) 컨테이너 클래스
//ViewModel, Router, UseCase 등 공통 인스턴스를 중앙에서 주입&공유 가능하게함
class DIContainer : ObservableObject{
    
    @Published var navigationRouter:NavigationRouter
    
    /// 선택된 탭을 제어
    @Published var selectedTab: TabItem
    
    /// DIContainer 초기화 함수
    /// 외부에서 navigationRouter와 useCaseService를 주입받아 사용할 수 있도록 구성
    /// 기본값으로는 각각 새로운 인스턴스를 생성하여 초기화
    init(
        navigationRouter: NavigationRouter = .init(),
        selectedTab: TabItem = .home
    ) {
        self.navigationRouter = navigationRouter
        self.selectedTab = selectedTab
    }
}
