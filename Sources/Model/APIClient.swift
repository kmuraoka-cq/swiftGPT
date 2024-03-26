import Foundation

struct APIClient {
    func postRequest(_ input: String) async throws -> String {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        // WARNING
        let token = ""
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let requestBody = RequestBody(
            model: "gpt-3.5-turbo",
            messages: [Message(role: "user", content: input)]
        )
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        
        // Treat as an error if the status code is not 200.
        if httpResponse?.statusCode != 200 {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NSError(domain: "APIError", code: httpResponse?.statusCode ?? 500, userInfo: [NSLocalizedDescriptionKey: errorResponse.error.message])
        }
        
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        
        guard let firstMessage = apiResponse.choices.first?.message.content else {
            throw NSError(domain: "No message found", code: 0, userInfo: nil)
        }
        
        return firstMessage
    }
}
