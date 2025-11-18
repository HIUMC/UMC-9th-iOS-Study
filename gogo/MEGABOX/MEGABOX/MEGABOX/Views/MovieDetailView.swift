import SwiftUI

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
            switch movie.title {
            case "F1 더 무비":
                VStack(alignment: .leading, spacing: 5) {
                    Image(.f1Top)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 4) {
                        Text(movie.title)
                            .font(.PretendardBold(size: 24))
                            .multilineTextAlignment(.center)
                        Text("F1 : The Movie")
                            .font(.PretendardMedium(size: 14))
                            .foregroundStyle(.gray03)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    Spacer().frame(height:5)
                    
                    Text("최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게\n레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.")
                        .font(.PretendardSemiBold(size: 16))
                        .foregroundStyle(.gray03)
                        .lineSpacing(2)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal,16)
                    
                    // 세그먼트 (상세정보 / 실관람평)
                    VStack {
                        HStack {
                            Button(action: {
                                selectedSegment = .info
                            }) {
                                VStack {
                                    Text("상세 정보")
                                        .font(.PretendardBold(size: 22))
                                        .foregroundStyle(selectedSegment == .info ? .black : .gray02)
                                    if selectedSegment == .info {
                                        Rectangle()
                                            .frame(height: 2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                            .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                            .animation(.easeInOut, value: selectedSegment)
                                    } else {
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.clear)
                                    }
                                }
                            }
                            Spacer()
                            Button(action: {
                                selectedSegment = .reviews
                            }) {
                                VStack {
                                    Text("실관람평")
                                        .font(.PretendardBold(size: 22))
                                        .foregroundStyle(selectedSegment == .reviews ? .black : .gray02)
                                    if selectedSegment == .reviews {
                                        Rectangle()
                                            .frame(height: 2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                            .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                            .animation(.easeInOut, value: selectedSegment)
                                    } else {
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(.clear)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                        .background(.clear)
                    }
                    
                    if selectedSegment == .info {
                        HStack(alignment: .top, spacing: 10) {
                            Image(.f1Bottom)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120)
                            VStack(spacing: 8) {
                                Text(movie.rating ?? "")
                                    .font(.PretendardSemiBold(size: 13))
                                    .foregroundStyle(.black)
                                Text(movie.releaseDate ?? "")
                                    .font(.PretendardSemiBold(size: 13))
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .alignmentGuide(.top) { _ in 0 }
                        }
                    } else {
                        
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
                    }
                }
                
            default:
                VStack {
                    Spacer()
                    Text("EmptyView")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                }
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

#Preview {
    MovieDetailView(movie: MovieModel(
        title: "F1 더 무비", poster: "poster3", countAudience: "30만", description: "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키\n\n한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고\n한순간에 추락한 드라이버 ‘손; 헤이스’(브래드 피트).\n그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGX에 합류한다.", releaseDate: "2025.06.25 개봉", rating: "12세 이상 관람가"
    ))
}
