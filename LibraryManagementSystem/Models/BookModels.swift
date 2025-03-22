import Foundation

struct Book: Identifiable, Codable {
    let id: UUID
    let isbn: String?
    let title: String
    let author: String
    let publisher: String?
    let publishedYear: Int?
    let description: String?
    let pageCount: Int?
    let genre: [String]?
    let imageUrl: String?
    let totalQuantity: Int
    let availableQuantity: Int
    let libraryId: UUID
    let addedById: UUID
    let addedByRole: UserType
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case isbn
        case title
        case author
        case publisher
        case publishedYear = "published_year"
        case description
        case pageCount = "page_count"
        case genre
        case imageUrl = "image_url"
        case totalQuantity = "total_quantity"
        case availableQuantity = "available_quantity"
        case libraryId = "library_id"
        case addedById = "added_by_id"
        case addedByRole = "added_by_role"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}