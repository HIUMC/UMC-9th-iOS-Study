//
//  CounterViewModel.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

import SwiftUI

//class CounterViewModel: ObservableObject {
//    @Published var count: Int = 0
//}

//@Observable
//final class CounterViewModel { var count = 0 }
//
//struct CounterParentView: View {
//    @State private var counter = CounterViewModel()           // 소유/수명
//    var body: some View {
//        VStack {
//            Text("부모: \(counter.count)")
//            CounterEditView(counter: counter)            // 주입(plain)
//        }
//    }
//}
//
//struct CounterEditView: View {
//    @Bindable var counter: CounterViewModel                   // 수정 권한(바인딩)
//    var body: some View {
//        Stepper("자식: \(counter.count)", value: $counter.count)
//    }
//}

/* viewModel */

import Foundation

@Observable
class CounterViewModel {
    var count = 0
}
//#Preview {
//    CounterParentView()
//}

