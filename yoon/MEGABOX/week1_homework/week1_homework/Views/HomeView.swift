//
//  HomeView.swift
//  week1_homework
//
//  Created by 정승윤 on 9/30/25.
//

//TODO: 라우터 이해하기.
import Foundation
import SwiftUI

enum MvTab: String, CaseIterable{
    case chart = "무비차트"
    case upcoming = "상영예정"
}
// 뷰 밖에다 써도 됌
struct HomeView: View {
    @Environment(NavigationRouter.self) var router
    @Environment(MovieViewModel.self) var movieViewModel
    @State private var tab: MvTab = .chart
    var body: some View {
        
            ScrollView(.vertical){
                VStack(alignment:.leading){
                    TopSection
                    Spacer().frame(height: 9)
                    ChartButton(select: $tab)
                    switch tab {
                    case .chart:
                        MovieList()
                    case .upcoming:
                        EmptyView()
                    }
                    Spacer().frame(height:37)
                    MovieFeed
                }.padding(.horizontal,16)
                    .padding(.top,23)
            }
        
    }
    // 스택 없이 컴포넌트 넣으면 페이지에 하나씩 생기는것 발견
    private var TopSection: some View {
        VStack(alignment: .leading, spacing: 8){
            Image(.meboxLogo2).frame(width: 149, height: 30)
            HStack {
                Button(action:{}){
                    Text("홈").font(.PretendardsemiBold24)
                        .foregroundStyle(.black)
                }
                Spacer()
                Button(action:{}){
                    Text("이벤트").font(.PretendardsemiBold24)
                        .foregroundStyle(.gray04)
                }
                Spacer()
                Button(action:{}){
                    Text("스토어").font(.PretendardsemiBold24)
                        .foregroundStyle(.gray04)
                }
                Spacer()
                Button(action:{}){
                    Text("선호극장").font(.PretendardsemiBold24)
                        .foregroundStyle(.gray04)
                }
            }.frame(width: 320)
        }
    }
    
    struct ChartButton: View {
        @Binding var select: MvTab
        var body: some View {
            HStack{
                ForEach(MvTab.allCases, id: \.self) {tab in
                    Button(action: {select = tab}){
                        Text(tab.rawValue).font(.Pretendardmedium14)
                            .foregroundStyle(select == tab ? .white : .gray04)
                            .frame(width: 84,height: 38)
                            .background(select == tab ? .gray08 : .gray02)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    // 안에다 넣어도, } 밖에다 넣어도 같다?
                    // enum 추가 학습 필요
                }
            }
        }
    }
    private var MovieFeed: some View {
        VStack(alignment: .leading){
            HStack{
                Text("알고보면 더 재미있는 무비피드").font(.PretendardBold24).foregroundStyle(.black)
                Spacer()
                Text(Image(systemName: "arrow.right")).foregroundStyle(.black)
            }
            Image(.himePoster).resizable().scaledToFit()
            Spacer().frame(height:44)
            VStack(alignment: .leading){
                MovieFeedDetail(img: Image(.hime2), explanation: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", example: "<모노노케 히메>,<퍼펙트 블루>")
                Spacer().frame(height:37)
                MovieFeedDetail(img: Image(.ugly2), explanation: "메가박스 오리지널 티켓 Re.37 <얼굴>", example: "영화 속 양극적인 감정의 대비")
                             
                }
            }
        }
    }
    
    struct MovieFeedDetail: View {
        let img: Image
        let explanation: String
        let example: String
        var body: some View {
            HStack{
                img.frame(width:100,height:100)
                Spacer().frame(width: 23)
                VStack{
                    Text(explanation).font(.PretendardsemiBold18).foregroundStyle(.black)
                    Spacer()
                    Text(example).font(.PretendardsemiBold13).foregroundStyle(.gray03)
                }
        }
    }
    }
    
    struct MovieCard: View {
        @Environment(NavigationRouter.self) var router
        let movie: MovieModel
        
        var body: some View {
                VStack {
                    
                        Image(movie.posterName)
                            .resizable()
                            .frame(width: 148, height: 212)
                            .onTapGesture {
                                router.push(.detail(movie))
                            }
                    
                    Button(action: {}){
                        Text("바로 예매")
                            .frame(width: 148,height: 36)
                            .foregroundStyle(.purple03)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.purple03, lineWidth: 1))
                    }
                    Spacer().frame(height: 8)
                    Text(movie.name).font(.PretendardBold22)
                    Spacer().frame(height: 3)
                    Text("누적관객수 \(movie.performance)").font(.Pretendardmedium18)
            }
        }
    } // Back 버튼은 네비게이션 때문에 생기는 것이다
    
    struct MovieList: View {
        @Environment(MovieViewModel.self) var movieViewModel
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack(spacing:24){
                    ForEach(movieViewModel.movies) { movie in MovieCard(movie: movie)}
                }
            })
        } // 2행 이상으로 가는게 아니니까 LazyHStack으로 충분하지 않을까.,
    }


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            HomeView()
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
