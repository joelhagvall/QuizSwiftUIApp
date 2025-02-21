import SwiftUI

struct ForwardBtn: View {
    var isPressed: Bool
    var text: String
    var background: Color = Color("GameColor")
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(50)
            .shadow(radius: 8)
            .scaleEffect(isPressed ? 2 : 1)
    }
}

#Preview {
    ForwardBtn(isPressed: false, text: "Next", background: Color("AccentColor"))
}
