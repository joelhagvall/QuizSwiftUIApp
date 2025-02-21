import Foundation
import SwiftUI

// ObservableObject - protocol that changes and the changes will be shown in ContentView.
class QuizLogic: ObservableObject {
    private(set) var quiz: [Quiz.Result] = []
    // Published - when this value changes, send an announcement, it'll reload the view!.
    @Published private(set) var length = 0
    @Published private(set) var index = 0
    @Published private(set) var reachedEnd = false
    @Published private(set) var answerSelected = false
    @Published private(set) var question: AttributedString = ""
    @Published private(set) var answerChoices: [Answer] = []
    @Published private(set) var score = 0
    var highScore = UserDefaults().integer(forKey: "HighScore")

    init(){
        saveHighScore()
        Task.init {
            await fetchQuestions()
        }
    }
    private enum QuizCategory {
        static let general = "https://opentdb.com/api.php?amount=10&type=boolean"
        static let knowledge = "https://opentdb.com/api.php?amount=10&category=9&type=boolean"
        static let entertainment = "https://opentdb.com/api.php?amount=10&category=11&type=boolean"
        static let television = "https://opentdb.com/api.php?amount=10&category=14&type=boolean"
        static let science = "https://opentdb.com/api.php?amount=10&category=30&type=boolean"
        
        static var random: URL {
            let urls = [general, knowledge, entertainment, television, science]
            return URL(string: urls.randomElement()!)!
        }
    }
    
    @MainActor
    func fetchQuestions() async {
        do {
            let url = QuizCategory.random
            let(data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            quiz = (try? decoder.decode(Quiz.self, from: data))?.results ?? []
            resetGame()
        } catch {
            print("Error fetching questions: \(error)")
        }
    }
    
    private func resetGame() {
        index = 0
        score = 0
        reachedEnd = false
        length = quiz.count
        setQuestion()
        updateHighScore()
    }
    
    private func updateHighScore() {
        let currentHighScore = UserDefaults.standard.integer(forKey: "HighScore")
        if score > currentHighScore {
            UserDefaults.standard.setValue(score, forKey: "HighScore")
        }
    }
    
    func goToNextQuestion(){
        guard index + 1 < length else {
            reachedEnd = true
            saveHighScore()
            return
        }
        index += 1
        setQuestion()
    }
    
    func setQuestion(){
        answerSelected = false

        guard index < length else {
            return
        }
        let quizQuestionIndex = quiz[index]
        question = quizQuestionIndex.formattedQuestion
        answerChoices = quizQuestionIndex.answers
    }
    
    func selectAnswer(answer: Answer){
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
    
    func saveHighScore(){
        UserDefaults().setValue(score, forKey: "HighScore")
    }
}
