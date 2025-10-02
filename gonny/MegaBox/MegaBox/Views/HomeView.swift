//
//  HomeView.swift
//  MegaBox
//
//  Created by 박병선 on 9/30/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject  var viewModel: HomeViewModel
  //  @EnvironmentObject var container: DIContainer
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // 상단 탭바
                TopTabBar()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // 카테고리 버튼(무비차트/상영예정)
                        CategorySelector()
                            .padding(.horizontal, 16)
                        
                        // 영화 포스터 가로 스크롤
                        PosterScrollSection(viewModel: viewModel)
                        
                        // 무비피드
                        MovieFeedSection()
                        
                        PromotionSection()
                    }
                    .padding(.vertical, 12)
                }
                
                .background(Color.white)
            }
        }
    }
    
    struct TopTabBar: View {
        let tabs = ["홈", "이벤트", "스토어", "선호극장"]
        @State private var selected = "홈"
        
        var body: some View {
            VStack (alignment: .leading, spacing: 10) {
                Image("megabox_logo")
                    .resizable()
                    .frame(width: 149, height: 30)
                    .padding(.leading)
                    .padding(.top)
                
                
                HStack(spacing: 24) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                            .font(.pretendardSemiBold(24))
                            .foregroundStyle(selected == tab ? .black00 : .gray06)
                            .onTapGesture { selected = tab }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
        }
    }
    
    struct CategorySelector: View {
        @State private var selected = "무비차트"
        let categories = ["무비차트", "상영예정"]
        
        var body: some View {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .font(.pretendardMedium(14))
                        .foregroundStyle(
                            selected == category
                            ? Color("white00")    // 선택된 경우
                            : Color("gray04")     // 선택 안 된 경우
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background {
                            if selected == category {
                                Capsule()
                                    .fill(Color("gray08")) // Liquid Glass 효과
                            } else {
                                Capsule()
                                    .fill(Color("gray02"))
                            }
                        }
                        .onTapGesture { selected = category }
                }
            }
        }
    }
    
    struct PosterScrollSection: View {
       // @EnvironmentObject var container: DIContainer
        @ObservedObject var viewModel: HomeViewModel
        var body: some View {
                VStack(alignment: .leading, spacing: 20) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                VStack {
                                    NavigationLink {
                                        MovieDetailView (
                                            movieDetail: MovieDetail.mock(for: movie),
                                            movie: movie
                                        )
                                    }
                                    label: {
                                        Image(movie.poster) // 뷰모델에서 제공한 poster
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 140, height: 200)
                                            .cornerRadius(8)
                                            .padding(.bottom, 5)
                                    }
                                    
                                    
                                    
                                    Button(action: {
                                        //예매 액션
                                    }) {
                                        Text("바로 예매")
                                            .font(.pretendardMedium(16))
                                            .foregroundStyle(.purple03)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 4)
                                            .background( RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.purple03, lineWidth: 1)  // 보라색
                                                .frame(width: 140, height: 36))
                                    }
                                    
                                    
                                    VStack(alignment: .leading, spacing: 5){
                                        Text(movie.title)
                                            .font(.pretendardBold(22))
                                            .foregroundStyle(.black00)
                                        
                                        
                                        Text(movie.audience)
                                            .font(.pretendardMedium(18))
                                            .foregroundStyle(.black00)
                                    }
                                    
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                }
            }
        }
    }
    
    struct MovieFeedSection: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("알고보면 더 재밌는 무비피드")
                        .font(.pretendardBold(24))
                        .foregroundStyle(.black00)
                    
                    Spacer()
                    Button(action: {
                        // 자세히 보기
                    }){
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.black00)
                    }
                    
                }
                .padding(.horizontal)
                
                Image("mono_asitaka")
                    .resizable()
                    .frame(width: 380,  height: 220)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
        }
    }
    struct FeedRow: View {
        let item: AdItem
        
        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                Image(item.imageName)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 92, height: 92)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.pretendardSemiBold(18))
                        .foregroundStyle(.black00)
                        .fixedSize(horizontal: false, vertical: true)   // 줄바꿈 자연스럽게
                        .lineLimit(2)
                    Spacer()
                    if let sub = item.subtitle, !sub.isEmpty {
                        Text(sub)
                            .font(.pretendardMedium(13))
                            .foregroundStyle(.gray03)
                    }
                }
                Spacer(minLength: 0)
            }
            .contentShape(Rectangle()) // 탭 영역 넓게
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
        }
    }
    
    struct PromotionSection: View {
        @StateObject private var vm = AdViewModel()
        
        var body: some View {
            VStack(spacing: 0) {
                ForEach(vm.items) { item in
                    // 필요하면 NavigationLink로 교체
                    FeedRow(item: item)
                    
                    // 들여쓴 Divider (썸네일 영역 제외)
                    Divider()
                        .padding(.leading, 18 + 92 + 16)
                }
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
