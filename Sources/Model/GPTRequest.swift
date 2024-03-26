struct RequestBody: Codable {
    let model: String
    let messages: [Message]
}

struct Message: Codable {
    let role: String
    let content: String
}
