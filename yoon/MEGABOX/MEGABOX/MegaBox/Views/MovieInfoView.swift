//
//  MovieinfoView.swift
//  week1_homework
//
//  Created by 정승윤 on 10/1/25.
//

import Foundation
import SwiftUI

// 패스뷰를 통해서 들어오면 패딩이 적용이 안됌
// NavigationStack -> 자식 뷰로 갈때 레이아웃이 달라지기 때문
// 패스 뷰로 들어왔을 때 레이아웃 깨지는걸 어떻게 해야 할지 모르겠음.,
struct MovieInfoView: View {
    let movie: MovieModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
        NavigationBar
        ScrollView {
                MovieInfo
                Spacer().frame(height: 35)
                MovieDetailBar
                Spacer().frame(height: 17)
                MovieDetail
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
        }.navigationBarBackButtonHidden(true)
    }
    // NavigationBar를 빼주니까 해결.
    // 아니면 하드코딩된 넓이를 수정해줘서 해결된건가?
    private var NavigationBar: some View {
        VStack{
            HStack{
                Button(action: {dismiss()
                }){Text(Image(systemName: "arrow.left")).foregroundStyle(.black)}
                    
                Spacer()
                
                Text(movie.name)
                        .font(.Pretendardmedium18)
                        .padding(.trailing,162)
                
            }.frame(maxWidth: .infinity)
           
        }.padding(.horizontal,16)
        
        }
    
    private var MovieInfo: some View {
        VStack(alignment: .center){
            Image(movie.secPosterName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight:248)
            Spacer().frame(height: 9)
            Text(movie.name).font(.PretendardBold24)
            Text(movie.engname).foregroundStyle(.gray03).font(.PretendardsemiBold14)
            Text("최고가 되지 못한 전설 VS 최고가 되고 싶은 루키 한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고 한순간에 추락한 드라이버 ‘손; 헤이스'(브래드 피트). 그의 오랜 동료인 ‘루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APGXP에 합류한다.").font(.PretendardsemiBold18).foregroundStyle(.gray03)
        }
    }
    private var MovieDetailBar: some View {
        HStack{
            VStack{
                Text("상세정보").font(.PretendardBold22)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }
            
            VStack{
                Text("실관람평").font(.PretendardBold22)
                Rectangle().frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
            }   
        }
    }
    private var MovieDetail: some View {
        HStack{
            Image(movie.posterName).resizable()
                .frame(width: 100,height: 120)
            VStack{
                Text("12세 이상 관람가").font(.PretendardsemiBold13)
                Spacer().frame(height:9)
                Text("2025.06.25 개봉").font(.PretendardsemiBold13)
            }
            Spacer()
        }
    }
}

struct MovieInfoView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            MovieInfoView(movie: MovieModel(posterName: "sample",secPosterName: "암거나",name:"영화제목",engname: "영어이름", performance: "100만명", age: "15"))
                .environment(NavigationRouter())
                .environment(MovieViewModel())
        }
    }
}
