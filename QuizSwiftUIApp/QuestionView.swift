import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizLogic: QuizLogic
    @State private var isAnimated = false
    
    private let animation = Animation.easeOut(duration: 1)
    
    var body: some View {
        VStack(spacing: 40) {
            questionHeader
            questionContent
            nextButton
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationBarHidden(true)
    }
    
    private var questionHeader: some View {
        Text("\(quizLogic.index + 1) of \(quizLogic.length)")
            .foregroundColor(Color("GameColor"))
    }
    
    private var questionContent: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(quizLogic.question)
                .font(.title2)
                .bold()
            
            answersView
        }
    }
    
    private var answersView: some View {
        ForEach(quizLogic.answerChoices) { answer in
            AnswerRow(answer: answer)
                .environmentObject(quizLogic)
                .transition(.move(edge: .leading))
                .offset(x: isAnimated ? 0 : -500)
                .onAppear { withAnimation(animation) { isAnimated = true } }
        }
    }
    
    private var nextButton: some View {
        Button(action: quizLogic.goToNextQuestion) {
            ForwardBtn(
                isPressed: false,
                text: "Next",
                background: quizLogic.answerSelected ? Color("GameColor") : .gray.opacity(0.3)
            )
        }
        .disabled(!quizLogic.answerSelected)
    }
}

#Preview {
    QuestionView()
        .environmentObject(QuizLogic())
}
