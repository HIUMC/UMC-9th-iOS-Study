//
//  EmptyView.swift
//  week1_homework
//
//  Created by 정승윤 on 10/3/25.
//

import Foundation
import SwiftUI

struct EmptyView: View {
    var body: some View {
        Text("Empty View")
    }
}

struct EmptyView_Preview: PreviewProvider {
    static var previews: some View {
        devicePreviews {
            EmptyView()
                .environment(NavigationRouter())
            
        }
    }
}
