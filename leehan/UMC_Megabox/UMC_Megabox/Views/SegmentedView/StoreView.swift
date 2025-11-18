//
//  StoreView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 9/30/25.
//

import SwiftUI

struct StoreView: View {
                                            
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                HStack { // megabox logo
                    Spacer().frame(width: 50)
                    Image("logo_megabox2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 149, height: 30)
                    Spacer().frame(width: 275)
                }.padding(.bottom, 6)
                
                SelectTheaterComponent(area: "강남")
                
                Spacer().frame(height: 37)
                
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        
                        // OrderMenuButton 코드에 만들어진 뷰 자체를 Button으로 만들면
                        // NavigationLink 막힘
                        // OrderMenuButton 은 Button 말고 그냥 뷰 자체로만 만들기
                        NavigationLink(destination: OrderPageView()){
                            OrderMenuButton(type: .large, title: "바로 주문", subtitle: "이제 줄서지 말고 모바일로 주문하고 픽업!", iconname: "icon_popcorn")
                        }
                        
                        VStack(spacing: 10) {
                            OrderMenuButton(type: .middle, title: "스토어 교환권", subtitle: nil, iconname: "icon_ticket")
                            OrderMenuButton(type: .middle, title: "선물하기", subtitle: nil, iconname: "icon_gift")
                        }
                    }
                    OrderMenuButton(type: .horizontal, title: "어디서든 팝콘 만나기", subtitle: "팝콘 콜라 스낵 모든 메뉴 배달 가능", iconname: "icon_motorcycle")
                }
                
                Spacer().frame(height: 30)
                
                Group {
                    VStack {
                        HStack {
                            Text("추천 메뉴")
                                .font(.PretendardBold(size: 22))
                                .foregroundStyle(.black)
                            Spacer()
                        }.padding(.bottom, 2)
                        
                        HStack {
                            Text("영화볼 때 뭐 먹을지 고민되면 추천 메뉴!")
                                .font(.PretendardRegular(size: 12))
                                .foregroundStyle(.gray03)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 20)
                
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                                .modifier(recommendedmenu())
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        }
                    }
                }.padding(.leading, 50)
                
                Spacer().frame(height: 60)
                
                Group {
                    VStack {
                        HStack {
                            Text("추천 메뉴")
                                .font(.PretendardBold(size: 22))
                                .foregroundStyle(.black)
                            Spacer()
                        }.padding(.bottom, 2)
                        
                        HStack {
                            Text("영화볼 때 뭐 먹을지 고민되면 추천 메뉴!")
                                .font(.PretendardRegular(size: 12))
                                .foregroundStyle(.gray03)
                            Spacer()
                        }
                        
                        Spacer().frame(height: 20)
                
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        }
                    }
                }.padding(.leading, 50)
                
            } // end of ScrollView
        } // end of NavigationStack
    }
}


#Preview {
    StoreView()
}

