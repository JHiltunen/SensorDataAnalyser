import SwiftUI

struct Upload: View {
    var body: some View {
        NavigationView {
            Button(action: {
                
            }) {
                Text("Send")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.indigo)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        } .padding()
    }
}

struct Upload_Previews: PreviewProvider {
    static var previews: some View {
        Upload()
    }
}
