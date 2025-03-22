import Foundation

enum UserType: String, Codable {
    case admin
    case librarian
    case member
}

struct UserProfile: Identifiable, Codable {
    let id: UUID
    let userType: UserType
    let libraryId: UUID
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case libraryId = "library_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Admin: Identifiable, Codable {
    let id: UUID
    let name: String
    let libraryId: UUID
    let email: String
    let phoneNumber: String?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case libraryId = "library_id"
        case email
        case phoneNumber = "phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Librarian: Identifiable, Codable {
    let id: UUID
    let name: String
    let age: Int?
    let email: String
    let phoneNumber: String?
    let libraryId: UUID
    let addedBy: UUID
    let status: LibrarianStatus
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case email
        case phoneNumber = "phone_number"
        case libraryId = "library_id"
        case addedBy = "added_by"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum LibrarianStatus: String, Codable {
    case pending
    case working
}

struct Member: Identifiable, Codable {
    let id: UUID
    let name: String
    let email: String
    let libraryId: UUID
    let gender: Gender?
    let preferredGenre: [String]?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case libraryId = "library_id"
        case gender
        case preferredGenre = "preferred_genre"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum Gender: String, Codable {
    case male
    case female
    case other
    case preferNotToSay = "prefer_not_to_say"
}