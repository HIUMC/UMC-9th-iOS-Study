import SwiftUI

@main
struct MegaBoxApp: App {
    @State private var router = NavigationRouter()
    @State private var viewModel = MovieViewModel()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(router)
                .environment(viewModel)
        }
    }
}
