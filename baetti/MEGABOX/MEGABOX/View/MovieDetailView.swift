//
//  MovieDetailView.swift
//  MEGABOX
//
//  Created by 박정환 on 10/1/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: MovieModel
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationBar(movie: movie)
            
            MovieDescriptionSection(movie: movie)

            MovieInfoSection(movie: movie)
                .padding(.top, 35)
        }
        .padding(.top, 8)
    }
    
    private struct NavigationBar: View {
        @Environment(\.dismiss) private var dismiss
        let movie: MovieModel

        var body: some View {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 44, height: 44)
                }
                Spacer()
                Text(movie.title)
                    .font(.system(size: 17, weight: .semibold))
                    .lineLimit(1)
                Spacer()
                // spacer for symmetric layout
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 8)
        }
    }
    
    private struct MovieDescriptionSection: View {
        let movie: MovieModel
        
        var body: some View {
            Image("f1poster")
                .resizable()
                .scaledToFill()
            
            VStack(alignment: .center, spacing: 0) {
                Text(movie.title)
                    .font(.system(size: 28, weight: .heavy))
                
                Text("F1 : The Movie") // 필요시 뷰모델에서 서브타이틀 바인딩
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray03)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.bottom, 9)

            VStack(alignment: .leading, spacing: 12) {
                Text("최고가 되지 못한 전설 VS 최고가 되고 싶은 루키")
                    .font(.semiBold18)
                    .foregroundColor(Color(.gray03))
                
                Text("""
한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).
그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.
""")
                .font(.semiBold18)
                .foregroundColor(Color(.gray03))
            }
            .padding(.horizontal, 16)
        }
    }
    
    private struct MovieInfoSection: View {
        let movie: MovieModel

        @State private var selectedTab: InfoTab = .detail

        private enum InfoTab: String, CaseIterable {
            case detail = "상세 정보"
            case review = "실관람평"
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 0) {
                    // 상세 정보 탭
                    VStack(spacing: 8) {
                        Button {
                            withAnimation(.easeInOut) { selectedTab = .detail }
                        } label: {
                            Text(InfoTab.detail.rawValue)
                                .font(.bold22)
                                .foregroundColor(selectedTab == .detail ? .black : .gray02)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Rectangle()
                            .fill(selectedTab == .detail ? Color.black : Color.gray02)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 실관람평 탭
                    VStack(spacing: 6) {
                        Button {
                            withAnimation(.easeInOut) { selectedTab = .review }
                        } label: {
                            Text(InfoTab.review.rawValue)
                                .font(.bold22)
                                .foregroundColor(selectedTab == .review ? .black : .gray02)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Rectangle()
                            .fill(selectedTab == .review ? Color.black : Color.gray02)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                if selectedTab == .detail {
                    HStack(alignment: .top, spacing: 16) {
                        Image(movie.poster)
                            .resizable()
                            .frame(width: 100, height: 120)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top) {
                                Text("12세 이상 관람가")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Text("2025.06.25 개봉")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                } else {
                    // Centered empty state card for reviews
                    HStack {
                        Spacer()
                        VStack(spacing: 12) {
                            Text("등록된 관람평이 없어요 🥺")
                                .font(.semiBold18)
                                .foregroundColor(.gray08)
                                .multilineTextAlignment(.center)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .frame(height: 141)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple02, lineWidth: 1)
                        )
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    // 미리보기용 더미 모델
    let sample = MovieModel(
        title: "F1 더 무비",
        poster: "poster3",
        countAudience: "30만"
    )
    return NavigationStack {
        MovieDetailView(movie: sample)
    }
}
