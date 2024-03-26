import Foundation
func main(arguments: [String]) {
    let semaphore = DispatchSemaphore(value: 0)
    Task {
        var input = ""
        arguments.forEach { argument in
            input += argument
        }
        do {
            let result = try await APIClient().postRequest(input)
            print("AI🤖：\n" + result)
        } catch {
            print("Error: \(error)")
        }
        semaphore.signal()
    }
    semaphore.wait()
}
main(arguments: readlints())

// TODO: tokenを入力するためのセットアップが必要
private func readlints() -> [String] {
    var lines: [String] = []
    print("Please input (End with Ctrl+D)")
    while let line = readLine() {
        if line.isEmpty { lines.append("\n")}
        lines.append(line + "\n")
    }
    return lines
}

