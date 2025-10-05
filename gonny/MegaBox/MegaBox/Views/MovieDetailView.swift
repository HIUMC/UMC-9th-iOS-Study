//
//  MovieDetailView.swift
//  MegaBox
//
//  Created by 박병선 on 10/2/25.
//
import SwiftUI

struct MovieDetailView: View {
    let movieDetail: MovieDetail
    let movie: Movie
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = MovieDetailViewModel()
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 네비게이션바
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
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
                    Image(movieDetail.poster)
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
                    CustomTabBar(selectedTab: $vm.selectedTab)
                    
                    //  탭별 컨텐츠
                    Group {
                        switch vm.selectedTab {
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
        @Binding var selectedTab: MovieDetailViewModel.Tab
        
        var body: some View {
            HStack {
                ForEach(MovieDetailViewModel.Tab.allCases, id: \.self) { tab in
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
                                    .fill(Color.purple)
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
            Image(movie.poster)
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
#Preview {
    NavigationStack {
        MovieDetailView(
            movieDetail:  MovieDetail(
                titleKR: "F1 더 무비",
                titleEN: "F1 : The Movie",
                poster: "f1_promotion",
                description: """
                최고가 되지 못한 전설 VS 최고가 되고 싶은 루키

                한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
                한순간에 추락한 드라이버 ‘슌 헤이스’(브래드 피트).
                그의 오랜 동료인 ‘루벤 세레브네스’(하비에르 바르뎀)에게
                레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.
                """,
                rating: "12세 이상 관람가",
                releaseDate: "2025.06.25"
            ),
            movie: Movie(title: "F1 더무비", poster: "f1_poster", audience: "50만")
           
        )
    }
}
