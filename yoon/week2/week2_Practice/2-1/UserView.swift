//
//  UserView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/20/25.
//

import SwiftUI

struct UserView: View {
    
    @StateObject var viewModel: UserViewModel1
    
    init() {
        self._viewModel = .init(wrappedValue: .init(userModel: .init(name: "제옹/정의찬", age: 29)))
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.increaseAge()
                }, label: {
                    Image(systemName: "arrow.up.square") // SFSymbol입니다. 0주차를 확인해주세요!
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.black)
                })
                
                Button(action: {
                    viewModel.decreaseAge()
                }, label: {
                    Image(systemName: "arrow.down.square")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.black)
                })
            }
            
            Group {
                Text("이름: \(viewModel.userModel.name)")
                Text("나이: \(viewModel.userModel.age)")
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    UserView()
}
