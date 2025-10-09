//
//  MovieDetailView.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import SwiftUI

struct MovieDetailView: View {
    @Environment(NavigationRouter.self) var router
    let movieDetail: MovieDetail
    //let movie: Movie
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        @Bindable var router = router
        
        VStack(spacing: 0) {
            // 상단 네비게이션바
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.black00)
                }
                Spacer()
                
                Text(movieDetail.titleKR)
                    .font(.pretendardSemiBold(18))
                Spacer()
                Spacer().frame(width: 18) // 오른쪽 버튼 없으니 균형용
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // 포스터 배너
                    Image(movieDetail.posterDetail)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 240)
                        .clipped()
                    
                    // 제목
                    VStack(spacing: 4) {
                        Text(movieDetail.titleKR)
                            .font(.pretendardBold(24))
                            .foregroundStyle(.black00)
                            
                        Text(movieDetail.titleEN)
                            .font(.pretendardMedium(14))
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                  
                    //.padding(.horizontal, 16)
                    
                    // 설명
                    Text(movieDetail.description)
                        .font(.pretendardSemiBold(15))
                        .foregroundStyle(.gray03)
                        .padding(.horizontal, 16)
                        .padding(.bottom)
                    
                    //  선택된 탭 내려주기
                    CustomTabBar(selectedTab: $viewModel.selectedTab)
                    
                    //  탭별 컨텐츠
                    Group {
                        switch viewModel.selectedTab {
                        case .info:
                            infoSection
                        case .reviews:
                            reviewSection
                        }
                    }
                    .padding(.horizontal, 16)
                     
                }
                .padding(.bottom, 24)
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Custom TabBar
    struct CustomTabBar: View {
        @Namespace private var animation
        @Binding var selectedTab: HomeViewModel.Tab
        
        var body: some View {
            HStack {
                ForEach(HomeViewModel.Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    } label: {
                        VStack {
                            Text(tab.rawValue)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(selectedTab == tab ? .black : .gray.opacity(0.5))
                            
                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color.purple03)
                                    .frame(height: 3)
                                    .matchedGeometryEffect(id: "underline", in: animation)
                            } else {
                                Capsule()
                                    .fill(Color.clear)
                                    .frame(height: 3)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
    // MARK: - 상세 정보
    private var infoSection: some View {
        HStack {
            Image(movieDetail.posterDetail)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 100)
                .padding(.top)
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movieDetail.rating)
                    .font(.pretendardSemiBold(13))
                    .foregroundStyle(.black00)
                   
                
                Text("\(movieDetail.releaseDate) 개봉")
                    .font(.pretendardSemiBold(13))
                    .foregroundStyle(.black00)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
         
        }
    }
    
    // MARK: - 실관람평
    private var reviewSection: some View {
        VStack(spacing: 12) {
            Text("등록된 관람평이 없어요 😢")
                .font(.pretendardSemiBold(18))
                .foregroundStyle(.gray08)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.purple02, lineWidth: 1)
                )
        }
    }
}
// MARK: - Preview
