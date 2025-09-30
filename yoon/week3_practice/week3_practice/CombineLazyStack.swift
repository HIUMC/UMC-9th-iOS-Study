//
//  CombineLazyStack.swift
//  week3_practice
//
//  Created by 정승윤 on 9/29/25.
//

//import Foundation
//import SwiftUI
//
//struct CombineLazyStack: View {
//
//    var body: some View {
//        ScrollView {
//            LazyVStack(spacing: 20, content: {
//                ForEach(1...10, id: \.self) { rowIndex in
//                    VStack(alignment: .leading, content: {
//                        Text("섹션 \(rowIndex)")
//                            .font(.headline)
//                        
//                        ScrollView(.horizontal, content: {
//                            LazyHStack(spacing: 10, content: {
//                                ForEach(1...10, id: \.self) { columnIndex in
//                                    Text("아이템 :\(columnIndex)")
//                                        .frame(width: 80, height: 80)
//                                        .background(Color.blue.opacity(0.3))
//                                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                                }
//                            })
//                            .padding(.bottom, 10)
//                        })
//                    })
//                }
//            })
//        }
//    }
//}
//
//#Preview {
//    CombineLazyStack()
//}

import SwiftUI

struct CombineLazyStack: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to Detail") {
                    path.append("Detail")
                }
            }
            .navigationDestination(for: String.self) { value in
                DetailView(title: value)
            }
            .navigationTitle("Home")
        }
    }
}

struct DetailView: View {
    let title: String

    var body: some View {
        Text("This is \(title) View")
            .navigationTitle(title)
    }
}

#Preview {
    CombineLazyStack()
}
