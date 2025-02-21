import Foundation

struct Answer: Identifiable, Equatable {
    let id = UUID()
    let text: AttributedString
    let isCorrect: Bool
    
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.isCorrect == rhs.isCorrect && lhs.text.description == rhs.text.description
    }
}
