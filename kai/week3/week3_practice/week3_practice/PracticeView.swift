//
//  PracticeView.swift
//  week3_practice
//
//  Created by 김지우 on 10/3/25.
//

import SwiftUI

struct ForEachArrayView: View {
    let fruits = ["🍎 Apple", "🍌 Banana", "🍊 Orange", "I would like to go home"]

    var body: some View {
        List {
            ForEach(fruits, id: \.self) { fruit in
                Text(fruit)
                    .font(.title2)
            }
        }
    }
}

struct ForEachArrayView_Previews: PreviewProvider {
    static var previews: some View {
        ForEachArrayView()
    }
}
