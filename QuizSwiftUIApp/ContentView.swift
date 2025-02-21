import SwiftUI

struct ContentView: View {
    @State private var animate = false
    @AppStorage("darkMode") private var darkMode = false
    // Make a new object as our app is launched, keep the object alive and pass it into ContentView.
    @StateObject var quizLogic = QuizLogic()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40){
                VStack(spacing: 20){
                    Image(systemName: "theatermasks")
                        .symbolEffect(.pulse)
                        .font(.system(size: 90))
                        .symbolRenderingMode(
                            .hierarchical
                        )
                    Text("Quiz")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("GameColor"))
                    
                }
                NavigationLink {
                    QuizView()
                    // Keep object alive and pass it in.
                        .environmentObject(quizLogic)
                } label: {
                    ForwardBtn(isPressed: false, text: "PLAY")
                }
                .padding()
                NavigationLink(
                    destination: InfoView(),
                    label: {
                        ForwardBtn(isPressed: false, text:"About game", background: Color(.gray))
                    })
                .accentColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(.systemGray5))
            .preferredColorScheme(darkMode ? .dark: .light)
        }
    }
}


#Preview {
    ContentView()
}
