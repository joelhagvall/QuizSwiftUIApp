import SwiftUI

struct InfoView: View {
    @AppStorage("darkMode") private var darkMode = false
    @Environment(\.presentationMode) var presentationMode
    var body : some View {
            Color.white.navigationTitle("Information")
            VStack {
                Toggle("Dark Mode", isOn: $darkMode)
                Text("This app is really simple, just click on Start game and the app will load the questions. At the end you will receive a score.")
                Button("Back"){
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .preferredColorScheme(darkMode ? .dark: .light)
    }
}

#Preview {
    InfoView()
}
