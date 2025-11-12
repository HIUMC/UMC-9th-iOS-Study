//
//  ContentView.swift
//  week2_Practice
//
//  Created by 정승윤 on 9/21/25.
//

/* View */

import SwiftUI

struct ContentView: View {
    
    var viewModel: CounterViewModel = .init()
    
    var body: some View {
        VStack {
            
            Text("\(viewModel.count)")
            
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("카운트 증가합니다.")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

