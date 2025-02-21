import Foundation

struct Quiz: Decodable {
    var results: [Result]
    
    struct Result: Decodable, Identifiable {
        var id: UUID {
            UUID()
        }
        var type, question, correctAnswer: String
        var incorrectAnswers: Set<String> = []

        var answers: [Answer] {
            var answers = [Answer]()
            guard let correctAnswer = try? AttributedString(markdown: correctAnswer) else {
                return answers.shuffled()
            }
            answers.append(Answer(text: correctAnswer, isCorrect: true))
            let incorrectAnswers = (try? incorrectAnswers.map { try AttributedString(markdown: $0) }) ?? []
            answers.append(contentsOf: incorrectAnswers.map { Answer(text: $0, isCorrect: false) })
            return answers.shuffled()
        }
    }
}

extension Quiz.Result {
    var formattedQuestion: AttributedString {
        do {
            return try AttributedString(markdown: question)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return ""
        }
    }
}
