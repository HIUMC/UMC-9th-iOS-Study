//
//  TabView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @State private var movieCard: MovieCardViewModel = .init()
    @State private var movieBoard: MovieBoardViewModel = .init()
    @State private var router = NavigationRouter()
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            ScrollView(.vertical) {
                LazyVStack {
                    
                    HeaderSection
                    
                    Spacer().frame(height: 9)
                    
                    Buttons
                    
                    Spacer().frame(height: 25)
                    
                    CinemaCard
                    
                    Spacer().frame(height: 38.5)
                    
                    MoreFunView
                    
                    Spacer().frame(height: 44)
                    
                    MovieBoardView
                    
                    
                    
                    
                }//.padding() /* end of LazyGrid */
            }.padding(.horizontal)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .login:
                    LoginView()
                    
                case .home:
                    HomeView()
                    
                case .detail(let movieCard):
                    DetailedMovieCardView(movieCard: movieCard)
                    
                case .booking:
                    BookingView()
                    
                case .store:
                    StoreView()
                    
                case .userInfo:
                    UserInfoView()
                }
            } /* end of ScrollView */
        }
    }
    
    /* --- 상단 헤더 섹션 --- */
    private var HeaderSection: some View {
        VStack {
            /* 메가박스 로고 */
            HStack {
                Image("logo_megabox2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                Spacer()
            }
            
            Spacer().frame(height: 8)
            
            /* 로고 밑 텍스트 */
            HStack {
                HStack {
                    Text("홈")
                        .font(.PretendardSemiBold(size: 24))
                        .foregroundStyle(.black)
                    Spacer()
                    Text("이벤트")
                        .font(.PretendardSemiBold(size: 24))
                        .foregroundStyle(.gray04)
                    Spacer()
                    Text("스토어")
                        .font(.PretendardSemiBold(size: 24))
                        .foregroundStyle(.gray04)
                    Spacer()
                    Text("선호극장")
                        .font(.PretendardSemiBold(size: 24))
                        .foregroundStyle(.gray04)
                }.frame(width: 320, height: 36)
                
                Spacer()
            }
        }
    }
    
    /* --- "무비차트" "상영예정" 버튼 --- */
    private var Buttons: some View {
        HStack {
            /* "무비차트" */
            Button(action: { } ) {
                ZStack {
                    Rectangle()
                        .frame(width: 84, height: 38)
                        .foregroundStyle(.gray08)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("무비차트")
                        .font(.PretendardMedium(size: 14))
                        .foregroundStyle(.white)
                }
            }
            
            Spacer().frame(width: 23)
            
            /* "상영예정" */
            Button(action: { } ) {
                ZStack {
                    Rectangle()
                        .frame(width: 84, height: 38)
                        .foregroundStyle(.gray02)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Text("상영예정")
                        .font(.PretendardMedium(size: 14))
                        .foregroundStyle(.gray04)
                }
            }
            
            Spacer()
        }
    }
    
    /* --- 무비카드 스크롤뷰 --- */
    private var CinemaCard: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: 24, content: {
                /*
                 ForEach 를 이용해 MovieCardViewModel에 있는 더미 데이터를 순환시킴
                 MovieCardViewModel에 있는 데이터를 movie로 받아서 하위 뷰로 넘겨줌
                 하위 뷰에서 movie의 데이터들을 이용해 뷰를 구성하도록 함
                 */
                /*
                 하위 뷰 개별로 봤을 땐 패딩 포함 요소들의 위치가 제대로 들어가있는데,
                 상위 뷰에서 네비게이션으로 들어가면 왜 패딩도 없어져있고 요소들의 위치도 달라져있는지
                 모르겠음
                 */
                ForEach(movieCard.movieCards) { movie in
                    
                    VStack {
                        Button( action: { router.push(.detail(movieCard: movie)) } ) {
                            Image(movie.MoviePoster)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 148, height: 212)
                        }
                        
                        
                        Spacer().frame(height: 8)
                        
                        Button( action: {  } ) {
                            RoundedRectangle(cornerRadius: 10)
                            /* stroke 사용시 foregroundedStyle 수정자보다 먼저 작성 + import Foundation */
                                .stroke(.purple03, lineWidth: 1)
                                .foregroundStyle(Color.clear)
                                .frame(width: 148, height: 36)
                                .overlay( Text("바로 예매")
                                    .font(.PretendardMedium(size: 16))
                                    .foregroundStyle(.purple03))
                        }
                        
                        Spacer().frame(height: 8)
                        
                        HStack {
                            Text(movie.MovieName)
                                .font(.PretendardBold(size: 22))
                                .foregroundStyle(.black)
                                .frame(height: 30)
                            Spacer()
                        }
                        
                        
                        Spacer().frame(height: 3)
                        
                        HStack {
                            Text("누적관객수 \(movie.People)")
                                .font(.PretendardMedium(size: 18))
                                .foregroundStyle(.black)
                                .frame(height: 21)
                            Spacer()
                        }
                        
                        
                    }.frame(width: 148) /* end of VStack */
                    
                }
            })
        }).frame(height: 318) /* end of LazyHStack */
    }
    
    /* --- 알고보면 더 재밌는 무비피드 --- */
    
    private var MoreFunView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("알고보면 더 재밌는 무비피드")
                    .font(.PretendardBold(size: 24))
                    .foregroundStyle(.black)
                Spacer()
                Button( action: { } ) {
                    RoundedRectangle(cornerRadius: 1000)
                        .frame(width: 39, height: 39)
                        .foregroundStyle(.gray00)
                        .overlay( Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 18)
                            .foregroundStyle(.gray08))
                }
            }.frame(height: 36)/* end of HStack */
            
            
            
            Image("image_morefunfeed")
                .resizable()
                .scaledToFit()
                .frame(height: 221)
        } /* end of VStack */
    }
    
    /* --- MovieBoard View --- */
    
    private var MovieBoardView: some View {
        VStack(alignment: .leading, spacing: 39, content: {
            ForEach(movieBoard.movieBoards) { board in
                
                HStack {
                    board.MovieImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    Spacer().frame(width: 23)
                    
                    VStack(alignment: .leading) {
                        Text(board.Title)
                            .font(.PretendardSemiBold(size: 18))
                            .foregroundStyle(.black)
                            .frame(height: 45)
                        
                        Spacer().frame(height: 25)
                        
                        Text(board.SubTitle)
                            .font(.PretendardSemiBold(size: 13))
                            .foregroundStyle(.gray03)
                            
                    }
                }
                
            }
        })
    }
    
}

#Preview {
    HomeView()
        .environment(NavigationRouter())
}
