//
//  MovieSheetView.swift
//  MEGABOX
//
//  Created by 고석현 on 10/9/25.
//

import SwiftUI

// MARK: - 영화 전체 목록 시트
// 이 시트는 "전체 영화" 버튼을 눌렀을 때 표시됨
// 영화 포스터들을 그리드로 보여주고, 하단의 검색바를 통해 영화 이름을 검색할 수 있음
// 구조: 상단(타이틀) - 중앙(영화 리스트) - 하단(항상 고정된 검색바)
struct MovieSheetView: View {
    // 영화 검색과 관련된 상태 관리를 위해 ViewModel을 StateObject로 선언
    @StateObject var viewModel: MovieSearchViewModel
    // 영화 선택 시 부모 뷰로 결과를 전달하는 클로저
    let onSelect: (MovieModel) -> Void
    // SwiftUI 환경값: 시트 닫기 위한 dismiss 함수
    @Environment(\.dismiss) var dismiss
    
    // 그리드 레이아웃(3열) 설정: LazyVGrid에서 사용
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        // ZStack을 사용해 검색바를 항상 화면 하단에 고정
        // alignment: .bottom으로 하여 검색바가 시각적으로 항상 맨 아래에 위치
        ZStack(alignment: .bottom) {
            // VStack: 상단 타이틀과 포스터 그리드(스크롤 영역) 구성
            VStack(spacing: 0) {
                // MARK: - 상단 타이틀
                // 영화 선택을 안내하는 텍스트, 시트의 맨 위에 위치
                headerView
                    .padding(.top, 20)
                    .padding(.bottom, 12)

                // MARK: - 영화 포스터 리스트
                // ScrollView로 감싸서 영화 목록만 스크롤 가능
                // LazyVGrid를 사용해 성능 저하 없이 많은 포스터를 표시
                ScrollView {
                    posterGrid
                        .padding(.horizontal, 16)
                        // 검색바 영역만큼 아래에 패딩을 줘서 마지막 아이템이 가려지지 않게 함
                        .padding(.bottom, 100)
                }
            }
            
            // MARK: - 하단 검색바
            // ZStack의 bottom alignment로 항상 화면 하단에 고정
            // 검색바는 VStack 외부에 위치하여 스크롤에 영향을 받지 않음
            searchBar
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
                .background(Color.white)
                // 살짝 그림자 효과로 시각적 분리
                .shadow(color: .gray.opacity(0.1), radius: 3, y: -1)
        }
        // 키보드가 올라올 때 시트가 자연스럽게 반응하도록 설정
        .ignoresSafeArea(.keyboard)
        .background(Color.white)
    }
}

// MARK: - 구성 요소들
private extension MovieSheetView {
    // MARK: 영화 선택 타이틀
    // 시트의 상단 제목 부분
    var headerView: some View {
        Text("영화 선택")
            .font(.PretendardBold(size: 20))
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
    
    // MARK: 영화 포스터 그리드
    // LazyVGrid를 이용해 효율적으로 포스터 이미지들을 배치
    // 각 영화 포스터는 Button으로 감싸져 있어 선택 가능
    // 영화 하나를 누르면 onSelect를 통해 상위 View로 전달하고 dismiss()로 시트를 닫음
    var posterGrid: some View {
        LazyVGrid(columns: columns, spacing: 24) {
            ForEach(movieList, id: \.id) { movie in
                Button {
                    // 영화 선택 시 부모뷰로 데이터 전달
                    onSelect(movie)
                    // 너무 빠르게 닫히는 현상을 막기 위해 약간의 지연 추가
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        dismiss()
                    }
                } label: {
                    VStack(spacing: 8) {
                        // 포스터 이미지
                        Image(movie.poster)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 95, height: 135)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        // 영화 제목
                        Text(movie.title)
                            .font(.PretendardSemiBold(size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    // MARK: 영화 리스트 필터링
    // 사용자가 검색어를 입력하면 해당 검색어가 포함된 영화만 표시
    // query가 비어 있으면 전체 리스트 반환
    var movieList: [MovieModel] {
        let trimmedQuery = viewModel.query.trimmingCharacters(in: .whitespaces)
        return trimmedQuery.isEmpty ? viewModel.movies : viewModel.results
    }
    
    // MARK: 하단 검색바
    // 사용자 입력을 viewModel.query와 바인딩
    // Combine을 통해 debounce, removeDuplicates 등으로 성능을 조정
    var searchBar: some View {
        HStack(spacing: 12) {
            // 검색 아이콘(돋보기)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            // TextField: 실시간으로 viewModel.query에 입력값을 반영
            // Combine 파이프라인에서 검색 로직이 자동으로 실행됨
            TextField("영화명을 입력해주세요", text: $viewModel.query)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            // 마이크 버튼(여기선 검색어 초기화 용도)
            Button {
                // 버튼을 누르면 검색어를 즉시 초기화
                viewModel.query = ""
            } label: {
                Image(systemName: "mic")
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        // UI 스타일: 부드럽게 둥근 캡슐 형태의 검색창
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(white: 0.95))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    // 미리보기용: 빈 onSelect 클로저 전달
    MovieSheetView(viewModel: MovieSearchViewModel()) { _ in }
}
