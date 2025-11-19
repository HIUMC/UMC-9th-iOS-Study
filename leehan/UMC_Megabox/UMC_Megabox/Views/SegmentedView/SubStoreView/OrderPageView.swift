//
//  OrderPageView.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/17/25.
//

import SwiftUI

struct OrderPageView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer().frame(width: 150)
                    Text("바로 주문")
                        .font(.PretendardRegular(size: 18))
                        .foregroundStyle(.black)
                    Spacer().frame(width: 120)
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }.padding(.horizontal)
                
                SelectTheaterComponent(area: "강남", backgroundcolor: .white)
                
                Divider()
                    .overlay( .gray02)
            }
            
            ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 15) {
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            .modifier(recommendedmenu())
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            .modifier(bestmenu())
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            .modifier(bestmenu())
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            .modifier(soldoutmenu())
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))
                            .modifier(soldoutmenu())
                        MenuCardComponent(menuInfo: .init(menuImage: "image_menu2", menuName: "더블 콤보", menuPrice: "10,010원"))

                    }.padding(.horizontal, 25)
                        .padding(.top, 10)
                    
                 // end of VStack
            } // end of ScrollView
        } // end of NavigationStack
    }
    
}

#Preview {
    OrderPageView()
}
