//
//  LazyHStackExample.swift
//  week3_practice
//
//  Created by 정승윤 on 9/29/25.
//

import Foundation
import SwiftUI

struct LazyHStackExample: View {

    var body: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: 15, content: {
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
    LazyHStackExample()
}
