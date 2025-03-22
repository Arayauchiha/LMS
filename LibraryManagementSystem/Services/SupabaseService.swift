import Foundation
import Supabase

class SupabaseService {
    static let shared = SupabaseService()
    
    private let client: SupabaseClient
    
    private init() {
        // Replace with your Supabase URL and API key
        let supabaseURL = URL(string: "YOUR_SUPABASE_URL")!
        let supabaseKey = "YOUR_SUPABASE_API_KEY"
        
        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey
        )
    }
    
    // MARK: - Authentication
    
    func signUp(email: String, password: String) async throws -> User {
        return try await client.auth.signUp(
            email: email,
            password: password
        )
    }
    
    func signIn(email: String, password: String) async throws -> Session {
        return try await client.auth.signIn(
            email: email,
            password: password
        )
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func resetPassword(email: String) async throws {
        try await client.auth.resetPasswordForEmail(email)
    }
    
    // MARK: - Database Operations
    
    func fetchUserProfile(userId: UUID) async throws -> UserProfile? {
        return try await client
            .from("user_profiles")
            .select()
            .eq("id", value: userId)
            .single()
            .execute()
            .value
    }
    
    // Add more database operations as needed
}