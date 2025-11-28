//
//  MobileOrderView.swift
//  MEGABOX
//
//  Created by 정승윤 on 11/18/25.
//
import SwiftUI
import Foundation

struct MobileOrderView: View {
    @State private var viewModel = MobileOrderViewModel()
    @State private var isDetailStyle: Bool = false
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
            VStack{
                HStack{
                    Image(.meboxLogo2).frame(width: 149, height: 30).padding(.horizontal,10)
                        
                    Spacer()
                }
                ScrollView{
                    TheaterTopBar(theaterName: "강남",onTapChange: { isDetailStyle.toggle()  })
                        .theaterTopBarStyle(isDetailStyle: isDetailStyle)
                    Spacer().frame(height:37)
                    MenuIcons(router: router)
                    Spacer().frame(height:25)
                    MenuScrollView(title: "추천 메뉴", menus: viewModel.recommendedMenus)
                    Spacer().frame(height:30)
                    MenuScrollView(title: "베스트 메뉴", menus: viewModel.bestMenus)
            }
        }
    }
    

    
    struct MenuIcons: View {
        let router: NavigationRouter
        var body: some View{
            VStack{
                HStack(alignment: .top){
                    FastOrder(router: router)
                    Spacer().frame(width:10)
                    VStack{
                        StoreExchange(router: router)
                        Gift(router: router)
                    }
                }
                PopcornDelivery(router: router)
            }.padding(.horizontal,10)
        }
    }
        
    
    struct FastOrder: View {
        let router: NavigationRouter
        var body: some View{
            Button(action:{
                router.push(.menuDetail)
            }){
                VStack(alignment: .leading) {
                    VStack(alignment:.leading) {
                        Text("바로 주문")
                            .font(.PretendardBold24)
                            .foregroundStyle(.black)
                        
                        Spacer().frame(height:5)
                        
                        Text("이제 줄서지 말고 \n모바일로 주문하고 픽업!")
                            .font(.Pretendardregular12)
                            .foregroundStyle(.gray03)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image(systemName: "popcorn")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                    }
                }
                .padding(10)
                .frame(width: 232, height:308)
                    .background{RoundedRectangle(cornerRadius: 10).stroke(Color.gray02, lineWidth: 1)}
            }
        }
    }
    
    struct StoreExchange: View {
        let router: NavigationRouter
        var body: some View{
            Button(action:{}){
                
                VStack(alignment:.leading){
                    Text("스토어 교환권")
                        .font(.PretendardBold22)
                        .foregroundStyle(.black)
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "ticket")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                         
                    }
                }.padding(10)
                    .frame(height:150)
                    .background{RoundedRectangle(cornerRadius: 10).stroke(Color.gray02, lineWidth: 1)
                    }
            }
        }
    }
    
    struct Gift: View {
        let router: NavigationRouter
        var body: some View{
            Button(action:{}){
                
                VStack(alignment:.leading){
                    Text("선물하기")
                        .font(.PretendardBold22)
                        .foregroundStyle(.black)
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "gift")
                            .font(.system(size: 24))
                            .foregroundStyle(.black)
                    }
                }.padding(10)
                .frame(height:150)
                    .background{RoundedRectangle(cornerRadius: 10).stroke(Color.gray02, lineWidth: 1)
                    }
            }
        }
    }
    
    struct PopcornDelivery: View {
        let router: NavigationRouter
        var body: some View{
            HStack{
                VStack(alignment:.leading){
                    Text("어디서든 팝콘 만나기")
                        .font(.PretendardBold24)
                    Spacer().frame(height:10)
                    Text("팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                        .font(.Pretendardregular12)
                        .foregroundStyle(.gray03)
                }
                Spacer()
                Image(systemName: "moped")
                    .font(.system(size: 24))
                    .foregroundStyle(.black)
            }
                .padding(10)
                .background{RoundedRectangle(cornerRadius: 10).stroke(Color.gray02,lineWidth: 1)
                }
        }
    }
    
    struct MenuScrollView: View {
        let title: String
        let menus: [MenuItemModel]
        @EnvironmentObject var router: NavigationRouter
        var body: some View {
            VStack(alignment: .leading){
                Text(title).font(.PretendardsemiBold24)
                
                if (title == "추천 메뉴") {
                    Text("영화 볼때 머먹지 고민될 땐 추천 메뉴!")
                        .font(.Pretendardregular12)
                
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(menus) { item in
                                Button {
                                    router.push(.menuDetail)
                                } label: {
                                    MenuCard(menu: item)
                                }
                            }
                        }
                    }
                }
                
                if (title == "베스트 메뉴") {
                    Text("영화 볼때 머먹지 고민될 땐 베스트 메뉴!").font(.Pretendardregular12)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(menus) { item in
                                Button {
                                    router.push(.menuDetail)
                                } label: {
                                    MenuCard(menu: item)
                                }
                            }
                        }
                    }
                }
            }.padding(10)
        }
    }
}


struct MobileOrderView_Preview: PreviewProvider {
   
    static var previews: some View {
        let router = NavigationRouter()
        devicePreviews {
            MobileOrderView()
                .environmentObject(router)
                
        }
    }
}

