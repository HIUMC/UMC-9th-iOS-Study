//
//  ContentView.swift
//  TestAlamofire
//
//  Created by 정승윤 on 11/5/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(ButtonInfoList.buttonList, id: \.id) { button in
                Button(action: {
                    button.action()
                }, label: {
                    Text(button.title)
                })
            }
        }
        .padding()
    }
}

struct ButtonInfo: Identifiable {
    var id: UUID = .init()
    var title: String
    var action: () -> Void
}

final class ButtonInfoList {
    
    static let serviceManager: ServiceManager = .init()
    
    static let buttonList: [ButtonInfo] = [
        .init(title: "GET", action: {
            Task {
                await serviceManager.getUser(name: "리버")
            }
        }),
        .init(title: "POST", action: {
            Task {
                await serviceManager.postUser(user: .init(name: "리버", age: 25, address: "서울특별시 성북구", height: 173))
                
            }
        }),
        .init(title: "PATCH", action: {
            Task {
                await serviceManager.patchUser(name: "River")
            }
        }),
        .init(title: "PUT", action: {
            Task {
                await serviceManager.putUser(user: .init(name: "리버", age: 21, address: "서울특별시 성북구", height: 180))
            }
        }),
        .init(title: "DELETE", action: {
            Task {
                await serviceManager.deleteUser(name: "리버")
            }
        }),
    ]
}

#Preview {
    ContentView()
}
