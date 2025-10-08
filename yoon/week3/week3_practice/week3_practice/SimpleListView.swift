//
//  ContentView.swift
//  week3_practice
//
//  Created by 정승윤 on 9/29/25.
//

//import SwiftUI
//
//struct SimpleListView: View {
//    let fruits = ["🍎 Apple", "🍌 Banana", "🍊 Orange", "🍇 Grape", "🍓 Strawberry"]
//
//    var body: some View {
//        List {
//            ForEach(fruits, id: \.self) { fruit in
//                Text(fruit)
//                    .font(.title2)
//            }
//        }
//    }
//}
//
//struct ForEachArrayView_Previews: PreviewProvider {
//    static var previews: some View {
//        SimpleListView()
//    }
//}

//import SwiftUI
//
//struct SimpleListView: View {
//    var body: some View {
//        ScrollView {
//                    VStack(spacing: 20) {
//                        ForEach(1...50, id: \.self) { index in
//                            Text("Item \(index)")
//                                .frame(maxWidth: .infinity)
//                                .background(Color.gray.opacity(0.2))
//                        }
//                    }
//                }
//                .scrollIndicators(.visible, axes: .vertical) // 스크롤 표시기 활성화
//                .contentMargins(.horizontal, 0, for: .scrollIndicators)
//    }
//}
//
//#Preview {
//    SimpleListView()
//}

//import SwiftUI
//
//struct SimpleListView: View {
//    @State private var scrollToIndex: Int = 0
//
//       var body: some View {
//           VStack {
//               ScrollViewReader { proxy in
//                   ScrollView {
//                       LazyVStack {
//                           ForEach(0..<50, id: \.self) { index in
//                               Text("Item \(index)")
//                                   .frame(maxWidth: .infinity)
//                                   .background(Color.blue.opacity(0.3))
//                                   .id(index) // 각 항목에 ID 부여
//                                   .padding()
//                           }
//                       }
//                   }
//                   .onChange(of: scrollToIndex) { oldIndex, newIndex in
//                       withAnimation {
//                           proxy.scrollTo(newIndex, anchor: .top) // 지정된 index로 스크롤 이동
//                       }
//                   }
//               }
//
//               HStack {
//                   Button("Top") { scrollToIndex = 0 }
//                   Button("Middle") { scrollToIndex = 25 }
//                   Button("Bottom") { scrollToIndex = 49 }
//               }
//           }
//       }
//}
//
//#Preview {
//    SimpleListView()
//}

//import SwiftUI
//
//struct SimpleListView: View {
//    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView {
//                LazyVStack {
//                    ForEach(1...50, id: \.self) { index in
//                        Text("Item \(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue.opacity(0.2))
//                            .padding(.horizontal)
//                            .id(index) // 각 아이템에 ID를 부여해야 scrollTo가 동작!!
//                    }
//                }
//            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    withAnimation {
//                        proxy.scrollTo(25, anchor: .center) // 25번 아이템으로 이동!!
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    SimpleListView()
//}

import SwiftUI

struct SimpleListView: View {
    @State private var scrollOffset: CGFloat = 0

        var body: some View {
            VStack {
                Text("Offset: \(Int(scrollOffset))")
                    .font(.headline)

                ScrollView {
                    LazyVStack {
                        ForEach(0..<50, id: \.self) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(0.3))
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    scrollOffset = proxy.frame(in: .global).minY
                                }
                                .onChange(of: proxy.frame(in: .global).minY) { oldValue, newValue in
                                    scrollOffset = newValue
                                }
                        }
                    )
                }
            }
        }
}

#Preview {
    SimpleListView()
}
