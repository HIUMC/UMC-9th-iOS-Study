//
//  LazyVStackExample.swift
//  week3_practice
//
//  Created by 정승윤 on 9/29/25.
//

import SwiftUI

struct LazyVstackExample: View {

    var body: some View {
        ScrollView(.vertical, content: {
            LazyVStack(spacing: 15, content: {
                ForEach(1...50, id: \.self) { index in
                    Text("아이템: \(index)")
                        .background(Color.green)
                        .frame(width: 100, height: 100)
                }
            })
        })
    }
}

#Preview {
    LazyVstackExample()
}
