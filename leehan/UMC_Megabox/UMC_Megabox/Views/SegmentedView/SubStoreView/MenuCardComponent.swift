//
//  MenuCardComponent.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/17/25.
//

import SwiftUI



struct MenuCardComponent: View {
    let menuInfo: MenuItemModel
    
    var body: some View {
        
        Button( action: { } ) {
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray01)
                    .frame(width: 190, height: 190)
                    .overlay(
                        Image(menuInfo.menuImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 168, height: 168)
                    )
                    
                    Spacer().frame(height: 16)
                Group {
                    HStack {
                        Text(menuInfo.menuName)
                            .font(.PretendardRegular(size: 13))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    
                    HStack {
                        Text(menuInfo.menuPrice)
                            .font(.PretendardSemiBold(size: 14))
                            .foregroundStyle(.black)
                        Spacer()
                    }
                }.frame(width: 190)
            }
        } // end of Button
    }
}

struct bestmenu: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
            VStack() {
                HStack() {
                    Image("bedge_red")
                    //clipShape을 통해 비대칭적인 cornerRadius 만드는 방법
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: 10
                        )))
                        .overlay( Text("BEST")
                            .font(.PretendardSemiBold(size: 12))
                            .foregroundStyle(.white))
                    Spacer()
                }
                Spacer()
            }
        )
    }
}

struct recommendedmenu: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
            VStack() {
                HStack() {
                    Image("bedge_blue")
                    //clipShape을 통해 비대칭적인 cornerRadius 만드는 방법
                        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: 10
                        )))
                        .overlay( Text("추천")
                            .font(.PretendardSemiBold(size: 12))
                            .foregroundStyle(.white))
                    Spacer()
                }
                Spacer()
            }
        )
    }
}

struct soldoutmenu: ViewModifier {
    func body(content: Content) -> some View {
        content
            .brightness(-0.7)
                .opacity(1)
                .overlay(
                    VStack {
                        Text("품절")
                            .font(.PretendardSemiBold(size: 14))
                            .foregroundStyle(.white)
                        Spacer().frame(height: 40)
                    }
                )
    }
}

#Preview {
    MenuCardComponent(menuInfo: .init(menuImage: "image_menu1", menuName: "러브 콤보", menuPrice: "10,000원"))
}



