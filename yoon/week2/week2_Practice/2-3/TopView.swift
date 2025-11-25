//
//  TopView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

struct TopView: View {
    @StateObject var viewModel: TextViewModel = .init()
    @State private var showBottomView = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Text("상위뷰입니다.")
                Text("텍스트 입력 값 : \(viewModel.inputText)")
                TextField("아무런 값을 넣어보세요!", text: $viewModel.inputText)
                    .frame(width: 350)
                
                Button("하위뷰 부르기") {
                    showBottomView.toggle()
                }
                .sheet(isPresented: $showBottomView) {
                    BottomView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    TopView()
}


