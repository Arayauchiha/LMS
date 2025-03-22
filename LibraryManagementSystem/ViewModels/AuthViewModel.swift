import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: UserProfile?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let supabaseService = SupabaseService.shared
    
    // Check if user is already logged in
    func checkAuthStatus() async {
        isLoading = true
        defer { isLoading = false }
        
        // Check if there's a session
        // Implementation depends on how Supabase Swift client handles sessions
        // This is a placeholder
    }
    
    // Admin login
    func loginAsAdmin(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let session = try await supabaseService.signIn(email: email, password: password)
            
            // Fetch user profile to check if they're an admin
            if let userId = session.user.id,
               let userProfile = try await supabaseService.fetchUserProfile(userId: userId) {
                if userProfile.userType == .admin {
                    DispatchQueue.main.async {
                        self.currentUser = userProfile
                        self.isAuthenticated = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "You are not authorized as an admin."
                        try? await self.supabaseService.signOut()
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    
    // Librarian login
    func loginAsLibrarian(email: String, password: String) async {
        // Similar to admin login but check for librarian user type
    }
    
    // Member login
    func loginAsMember(email: String, password: String) async {
        // Similar to admin login but check for member user type
    }
    
    // Sign out
    func signOut() async {
        isLoading = true
        
        do {
            try await supabaseService.signOut()
            DispatchQueue.main.async {
                self.currentUser = nil
                self.isAuthenticated = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}