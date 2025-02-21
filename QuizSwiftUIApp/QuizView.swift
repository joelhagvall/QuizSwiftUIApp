import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizLogic: QuizLogic
    var body: some View {
        if quizLogic.reachedEnd {
            VStack(spacing: 20){
                Text("Trivia Game")
                    .blueTitle()
                Text("GAME OVER")
                Text("You scored \(quizLogic.score) out of \(quizLogic.length)")
                Text("Current high score: \(quizLogic.highScore)")
                
                Button {
                    Task.init {
                        await quizLogic.fetchQuestions()
                    }
                } label : {
                    ForwardBtn(isPressed: false, text: "Play again")
                }
            }
            .foregroundColor(Color("GameColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .navigationBarHidden(true)
        } else {
            QuestionView()
                        .environmentObject(quizLogic)
        }
    }
}

#Preview {
    QuizView()
        .environmentObject(QuizLogic())
}
