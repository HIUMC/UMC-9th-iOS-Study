import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: MovieModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedSegment: DetailSegment = .info
    @Namespace private var underlineNamespace
    
    enum DetailSegment: String, CaseIterable {
        case info = "상세 정보"
        case reviews = "실관람평"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - 상단 대형 이미지 (poster 또는 backdrop 용)
                KFImage(URL(string: movie.backdrop ?? movie.poster))
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 250)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                // MARK: - 제목 / 부제목
                VStack(spacing: 4) {
                    Text(movie.title)
                        .font(.PretendardBold(size: 24))
                        .multilineTextAlignment(.center)
                    
                    // 원제는 없으므로 같은 제목 표시 (원한다면 MovieModel 수정)
                    Text(movie.title)
                        .font(.PretendardMedium(size: 14))
                        .foregroundStyle(.gray03)
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
                // MARK: - 줄거리
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.description ?? "")
                        .font(.PretendardSemiBold(size: 16))
                        .foregroundStyle(.gray03)
                        .lineSpacing(4)
                        .padding(.horizontal,16)
                }
                .padding(.top, 20)
                
                
                // MARK: - 세그먼트 선택 (상세 정보 / 실관람평)
                segmentSelector
                
                
                // MARK: - 세그먼트 별 내용
                if selectedSegment == .info {
                    infoSection
                } else {
                    reviewSection
                }
                
                Spacer().frame(height: 60)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("goback")
                        .foregroundStyle(.black)
                        .padding(.leading, -25)
                }
            }
        }
    }
}



// MARK: - 세그먼트 버튼
private extension MovieDetailView {
    
    var segmentSelector: some View {
        HStack {
            ForEach(DetailSegment.allCases, id: \.self) { segment in
                Button {
                    withAnimation(.easeInOut) {
                        selectedSegment = segment
                    }
                } label: {
                    VStack {
                        Text(segment.rawValue)
                            .font(.PretendardBold(size: 22))
                            .foregroundStyle(selectedSegment == segment ? .black : .gray02)
                        
                        if selectedSegment == segment {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.black)
                                .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                        } else {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.clear)
                        }
                    }
                }
                
                if segment != DetailSegment.allCases.last {
                    Spacer()
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 16)
    }
}


// MARK: - 상세 정보 섹션
private extension MovieDetailView {
    
    var infoSection: some View {
        HStack(alignment: .top, spacing: 15) {
            
            KFImage(URL(string: movie.poster))
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 180)
                }
                .resizable()
                .scaledToFit()
                .frame(width: 120)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(movie.rating ?? "관람등급 정보 없음")
                    .font(.PretendardSemiBold(size: 13))
                
                Text(movie.releaseDate ?? "개봉일 정보 없음")
                    .font(.PretendardSemiBold(size: 13))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}


// MARK: - 실관람평 섹션
private extension MovieDetailView {
    
    var reviewSection: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("등록된 관람평이 없어요🥲 ")
                    .font(.PretendardSemiBold(size: 16))
                    .foregroundStyle(.gray08)
                Spacer()
            }
            Spacer()
        }
        .frame(height: 200)
    }
}


#Preview {
    MovieDetailView(
        movie: MovieModel(
            title: "테스트 영화",
            poster: "https://image.tmdb.org/t/p/w342/vSMWJkBTEfa7kFxHizSz4uJNVlf.jpg",
            countAudience: "30만",
            description: "줄거리 예시입니다.",
            releaseDate: "2025.06.25 개봉",
            rating: "12세 이상 관람가",  backdrop: "https://image.tmdb.org/t/p/w780/abcd1234.jpg"   // ← 실제 문자열
        )
    )
}
 
