import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                LoadingView()
            } else if authViewModel.isAuthenticated {
                switch authViewModel.currentUser?.userType {
                case .admin:
                    AdminDashboardView()
                case .librarian:
                    LibrarianDashboardView()
                case .member:
                    MemberDashboardView()
                case nil:
                    LoginView()
                }
            } else {
                LoginView()
            }
        }
        .task {
            await authViewModel.checkAuthStatus()
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
                .padding()
        }
    }
}