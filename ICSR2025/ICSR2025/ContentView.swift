import SwiftUI

@main
struct ICSR2025App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .light)
        }
    }
}

struct ContentView: View {
    var body: some View {
        WelcomePageView()
    }
}

#Preview {
    ContentView()
}
