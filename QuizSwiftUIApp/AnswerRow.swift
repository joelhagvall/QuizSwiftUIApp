import SwiftUI

struct AnswerRow: View {
    @EnvironmentObject var quizLogic: QuizLogic
    var answer: Answer
    @State private var isSelected = false
    
    private static let green = Color(.green)
    private static let red = Color(.red)
    private static let gray = Color(.gray)
    
    var body: some View {
        HStack(spacing: 10) {
            Text(answer.text)
                .bold()
        }
        .scenePadding()
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundColor(Color("GameColor"))
        .background(.white)
        .clipShape(Capsule())
        .shadow(
            color: isSelected ? (answer.isCorrect ? Self.green : Self.red) : Self.gray,
            radius: 10,
            x: 0.5,
            y: 0.5
        )
        .onTapGesture {
            guard !quizLogic.answerSelected else { return }
            isSelected = true
            quizLogic.selectAnswer(answer: answer)
        }
    }
}

#Preview {
    AnswerRow(answer: Answer(text: "Option", isCorrect: false))
        .environmentObject(QuizLogic())
}
