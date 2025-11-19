//
//  OrderMenuButton.swift
//  UMC_Megabox
//
//  Created by 이한결 on 11/16/25.
//

import SwiftUI

// 버튼의 모양을 열거형으로 정의
enum OrderMenuButtonType {
    case large // 큰 버전
    case middle // 작은 버전
    case horizontal // 가로 버전
}

struct OrderMenuButton: View {
    let type: OrderMenuButtonType // 버튼의 모양
    let title: String
    let subtitle: String? // 부제는 없을수도 있음
    let iconname: String
    
    var body: some View {
        switch type {
        case .large:
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray02, lineWidth: 1)
                .foregroundStyle(Color.clear)
                .frame(width: 222, height: 308)
                .overlay( VStack {
                    HStack { Text(title)
                            .font(.PretendardBold(size: 24))
                            .foregroundStyle(.black)
                            Spacer() }.padding(.horizontal, 12)
                                        .padding(.vertical, 3)
                                        .padding(.top, 15)
                    
                    HStack { Text(subtitle ?? "")
                            .font(.PretendardRegular(size: 12))
                            .foregroundStyle(.gray03)
                             Spacer() }.padding(.horizontal, 12)
                        
                    Spacer()
                    
                    HStack { Spacer()
                             Image(iconname)
                            .frame(width: 50)
                            .foregroundStyle(.black) }.padding(.horizontal, 12)
                                                        .padding(.bottom, 15)
                })
            
        case .middle:
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray02, lineWidth: 1)
                .foregroundStyle(Color.clear)
                .frame(width: 140, height: 150)
                .overlay( VStack {
                    HStack { Text(title)
                            .font(.PretendardBold(size: 18))
                            .foregroundStyle(.black)
                            Spacer() }.padding(.horizontal, 12)
                                        .padding(.vertical, 3)
                                        .padding(.top, 15)
                    
                    HStack { Text(subtitle ?? "")
                            .font(.PretendardRegular(size: 12))
                            .foregroundStyle(.gray03)
                             Spacer() }.padding(.horizontal, 12)
                        
                    Spacer()
                    
                    HStack { Spacer()
                             Image(iconname)
                            .frame(width: 50)
                            .foregroundStyle(.black) }.padding(.horizontal, 12)
                                                        .padding(.bottom, 15)
                })
            
        case .horizontal:
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray02, lineWidth: 1)
                .foregroundStyle(Color.clear)
                .frame(width: 380, height: 104)
                .overlay(
                          HStack {
                              VStack {
                                  HStack { Text(title)
                                          .font(.PretendardBold(size: 20))
                                          .foregroundStyle(.black)
                                           Spacer() }.padding(.leading, 10)
                                  
                                  HStack { Text(subtitle ?? "")
                                          .font(.PretendardRegular(size: 12))
                                          .foregroundStyle(.gray03)
                                           Spacer() }.padding(.leading, 10)
                                                     .padding(.top, 1)
                                      }
                                  Spacer()
                    
                                  HStack { Spacer()
                                           Image(iconname)
                                          .frame(width: 50)
                                      .foregroundStyle(.black) }.padding(.trailing, 10)
                                })
        }
    }
}

#Preview {
    OrderMenuButton(type: .horizontal, title: "어디서든 팝콘 만나기", subtitle: "팝콘, 콜라, 스낵 모든 메뉴 배달 가능!", iconname: "icon_motorcycle")
}

