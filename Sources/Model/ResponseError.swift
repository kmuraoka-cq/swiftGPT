struct APIError: Codable {
    let message: String
    let type: String
    let param: String?
    let code: String?
}

struct ErrorResponse: Codable {
    let error: APIError
}
