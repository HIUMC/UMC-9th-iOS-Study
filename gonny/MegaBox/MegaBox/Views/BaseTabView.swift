//
//  BaseTabView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.
//
import SwiftUI

struct BaseTabView: View {
    @EnvironmentObject var container: DIContainer
        
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            
            Tab(value: 0) {
                HomeView(viewModel: HomeViewModel())
            } label: {
                VStack {
                    Image("home_icon")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("홈")
                        .font(.pretendardMedium(10))   // 원하는 폰트 적용
                        .foregroundStyle(.black00)     // 색상도 변경 가능
                }
            }
            
            
            Tab(value: 1) {
                ReserveView()
            } label: {
                VStack {
                    Image("reserve_icon")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("바로 예매")
                        .font(.pretendardMedium(10))   // 원하는 폰트 적용
                        .foregroundStyle(.black00)
                }
            }
            
            Tab(value: 2) {
                MobileOrderView()
            } label: {
                VStack {
                    Image("mobileOrder_icon")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("모바일 오더")
                        .font(.pretendardMedium(10))   // 원하는 폰트 적용
                        .foregroundStyle(.black00)
                }
            }
            
            Tab(value: 3) {
                ProfileView()
            } label: {
                VStack {
                    Image("mypage_icon")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("프로필")
                        .font(.pretendardMedium(10))   // 원하는 폰트 적용
                        .foregroundStyle(.black00)
                }
            }
          
        }
    }
}
    
    #Preview {
        BaseTabView()
    }

