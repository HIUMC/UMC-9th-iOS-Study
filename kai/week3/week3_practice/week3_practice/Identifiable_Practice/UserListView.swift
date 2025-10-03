//
//  UserListView.swift
//  week3_practice
//
//  Created by 김지우 on 10/3/25.
//

import SwiftUI

struct UserListView: View {
    @State private var users = [
        User(name: "Alice", age: 24),
        User(name: "Bob", age: 30),
        User(name: "Charlie", age: 28)
    ]
    
    @State private var selectedUser: User?

    var body: some View {
        NavigationView {
            List {
                ForEach($users) { $user in
                    NavigationLink(destination: UserEditView(user: $user)) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("\(user.age) years old")
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
