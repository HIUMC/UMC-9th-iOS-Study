import SwiftUI

@main
struct MegaBoxApp: App {
    @State private var router = NavigationRouter()
    @StateObject private var viewModel = MovieViewModel()
    var body: some Scene {
        WindowGroup {
            BookingView()
                .environment(router)
                .environmentObject(viewModel)
        }
    }
}
