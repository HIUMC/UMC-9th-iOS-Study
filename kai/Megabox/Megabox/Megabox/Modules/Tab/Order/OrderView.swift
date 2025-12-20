//
//  OrderView.swift
//  Megabox
//
//  Created by 김지우 on 11/20/25.
//

import Foundation
import SwiftUI

struct OrderView: View {
    var body: some View {
        ScrollView(){
            VStack(alignment:.leading){
                header
                
                //극장 변경
                
                //네모버튼모음
                ButtonList()
                
                recommendedMenuStack
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

                
            
        }
        
    }
    
    //상단 로고
    private var header: some View {
        HStack{
            
            Image(.megaboxLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Spacer()
        }
        .padding()
    }
    
    private var recommendedMenuStack: some View{
        VStack{
        MenuHeader(title: "추천 메뉴",description: "영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
        
        }
    }
    
    
    /*
    private var recommendedMenu: some View{
        
    }
    
    private var bestMenu: some View{
        MenuHeader(title: "베스트 메뉴", description: "영화 볼때 뭐먹지 고민될 때 베스트 메뉴!")
    }
    */

    
    
}

//사각형 버튼 모음
struct ButtonList: View{
    
    var body: some View{
        VStack(alignment:.center){
            //버튼 모음 1
            HStack{
                buttonList1
                Spacer()
                    .frame(width:15)
                buttonList2
            }
            
            Spacer()
                .frame(height:40)
           
            //버튼 2
            buttonList3
        }
        .padding(10)
        
            

    }
    
    private var buttonList1: some View{
        //바로 주문
        PrimaryButton(title:"바로 주문", imageName: "popcorn", description:"이제 줄서지 말고\n모바일로 주문하고 픽업!")
            .frame(width:208, height:310)
    }
    private var buttonList2: some View{
        VStack{
            
            //스토어 교환권
            
            PrimaryButton(title: "스토어 교환권", imageName: "ticket")
                .frame(width:150, height:150)

            Spacer()
                .frame(height:10)
            
            //선물하기
            PrimaryButton(title: "선물하기",imageName:"gift")
                .frame(width:150, height:150)

            
        }
    }
    
    private var buttonList3: some View{
            PrimaryButton(title: "어디서든 팝콘 만나기", imageName: "delivery",description: "팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                .frame(width:373,height:54)

        
    }
}

//컴포넌트 - 바로가기 버튼 모음
struct PrimaryButton: View{
    let title:String
    //상황에 따라 입력값 유무가 달라지는 변수들은 let이 아니라 var로 설정
    let imageName :String
    var description: String? = nil //설명(회색글씨)가 없는 버튼은 디폴트값 설정
    var action:() -> Void = {} //액션이 지정되지 않은 버튼은 디폴트값 설정
    
    var body: some View{
        Button(action: action){
            
            VStack(alignment: .leading){
                
                //버튼 이름
                Text(title)
                    .foregroundStyle(Color.black01)
                    .font(.PretendardExtraBold(size: 22))
                
                //설명
                if let description = description {
                    Text(description)
                        .font(.PretendardRegular(size: 12))
                        .foregroundStyle(Color.gray05)
                        
                }
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    //아이콘
                    Image(.init(imageName))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                }//HStack_end
            }//VStack_end
        }
        .modifier(CustomButtonStyle())
    }
    
    //텍스트 영역
    
}

//컴포넌트 - 바로가기 버튼 스타일
struct CustomButtonStyle: ViewModifier{
    func body(content: Content) -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
            
            content
                .padding(10)
        }
        
        
    }
}

struct MenuHeader: View{
    let title: String
    let description: String
    
    
    var body: some View{
        VStack(alignment:.leading){
            Text(title)
                .font(Font.PretendardExtraBold(size: 22))
                .foregroundStyle(Color.black01)
            
            Spacer()
                .frame(height: 10)
            
            Text(description)
                .font(Font.PretendardRegular(size: 12))
                .foregroundStyle(Color.gray03)
        }
    }
    

}

struct MenuStack: View{
    let imageName: String
    let menuName: String
    let price: String
    var bestrecommend: String? = nil
    
    var body: some View{
        VStack(alignment:.leading){
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width:152, height: 152)
            
            Text(menuName)
                .font(Font.PretendardRegular(size: 13))
                .foregroundStyle(Color.black01)
            
            Text(price)
                .font(Font.PretendardRegular(size: 14))
                .foregroundStyle(Color.black01)
        }
    }
}

struct MenuCustomStyle_best: ViewModifier{
    func body(content: Content) -> some View{
        ZStack(alignment:.topLeading){
            content
            
            Rectangle()
                .fill(Color.bestred)
                .frame(width:51, height:25)
                .overlay { Text("Best")
                        .font(.PretendardBold(size: 12))
                    .foregroundColor(.white) }

                
        }
        .clipped()
        
        
    }
}

struct MenuCustomStyle_recommend: ViewModifier{
    func body(content: Content) -> some View{
        ZStack(alignment:.topLeading){
            content
            
            Rectangle()
                .fill(Color.recommendblue)
                .frame(width:51, height:25)
                .overlay { Text("추천")
                        .font(.PretendardBold(size: 12))
                    .foregroundColor(.white) }

        }
        .clipped()
    }
}

#Preview {
    OrderView()
}
