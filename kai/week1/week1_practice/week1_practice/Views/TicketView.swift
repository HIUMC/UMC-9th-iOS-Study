//
//  ContentView.swift
//  week1_practice
//
//  Created by 김지우 on 9/17/25.
//

import SwiftUI

struct TicketView: View {
    var body: some View {
        ZStack {
                    Image(.background)
                    
                    VStack {
                        
                        Spacer().frame(height: 111)
                        
                        mainTitleGroup
                        
                        Spacer().frame(height: 134)
                        
                        mainBottomGroup
                    }
                }
                .padding()//ZStack_End
    }
    
    //상단 Title VStack
    private var mainTitleGroup: some View {
           VStack {
               Group {
                   Text("마이펫의 이중생활")
                       .font(.PretendardBold(size: 30))
                       .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)

                   Text("본인 + 동반 1인")
                       .font(.PretendardRegular(size:16))
                   Text("30,100원")
                       .font(.PretendardRegular(size:24))
               }//Group_end
               .foregroundStyle(Color.white)
           }//VStack_end
       }
    
    //예약하기 버튼
    private var mainBottomGroup: some View {
        Button(action: {
                   print("Hello")
               }, label: {
                   VStack {
                       Image(systemName: "chevron.up")
                           .resizable()
                           .frame(width: 18, height: 12)
                       Text("예매하기")
                           .font(.PretendardSemiBold(size:18))
                           .foregroundStyle(Color.white)
                   }//VStack_end
                   .frame(width: 63, height: 40)
               })//Button_end
           }
    }


#Preview {
    TicketView()
}

