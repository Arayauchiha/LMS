import Foundation

struct Library: Identifiable, Codable {
    let id: UUID
    let name: String
    let libraryCode: String
    let address: String?
    let contactEmail: String?
    let contactPhone: String?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case libraryCode = "library_code"
        case address
        case contactEmail = "contact_email"
        case contactPhone = "contact_phone"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}