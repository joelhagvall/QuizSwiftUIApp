import Foundation
import SwiftUI

extension Text {
    func blueTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AccentColor"))
    }
}
