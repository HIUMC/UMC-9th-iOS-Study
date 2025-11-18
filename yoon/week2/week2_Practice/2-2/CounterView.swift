//
//  CounterView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/20/25.
//

import SwiftUI

//struct CounterView: View {
//    @State private var count = 0  // 상태 프로퍼티 선언
//
//    var body: some View {
//        VStack {
//            Text("카운트: \(count)") // 값이 변경되면 자동 업데이트
//                .font(.largeTitle)
//
//            Button("증가") {
//                count += 1  // 상태 변경 시 UI 자동 업데이트
//            }
//            .padding()
//        }
//    }
//}

//struct CounterView: View {
//    @State private var text: String = ""
//
//    var body: some View {
//        VStack {
//            Text("텍스트 내용: \(text)")
//                .font(.largeTitle)
//
//            TextField("아무 값을 입력해보세요!", text: $text)
//                .frame(width: 350)
//        }
//    }
//}

//struct CounterView: View {
//    @State private var isClicked: Bool = false
//
//    var body: some View {
//        VStack {
//            Text("현재 State 변수 값: \(isClicked)")
//            
//            CustomButton(isClicked: $isClicked)
//        }
//    }
//}

// ObservedObject 
//struct CounterView: View {
//    @ObservedObject var viewModel: CounterViewModel = .init()
//
//    var body: some View {
//        VStack {
//            Text("\(viewModel.count)")
//            
//            Button(action: {
//                viewModel.count += 1
//            }, label: {
//                Text("카운트 증가 버튼")
//            })
//        }
//    }
//}

// StateObject //
//struct CounterView: View {
//    @StateObject var viewModel: CounterViewModel = .init()
//
//    var body: some View {
//        VStack {
//            Text("\(viewModel.count)")
//            
//            Button(action: {
//                viewModel.count += 1
//            }, label: {
//                Text("카운트 증가 버튼")
//            })
//        }
//    }
//}
//

//import SwiftUI
//  
//struct CounterView: View {
//    @StateObject var viewModel: CounterViewModel = .init()
//
//    var body: some View {
//        VStack {
//            Text("\(viewModel.count)")
//            
//            Button(action: {
//                viewModel.count += 1
//            }, label: {
//                Text("카운트 증가 버튼")
//            })
//        }
//    }
//}
//
//#Preview {
//    CounterView()
//}

