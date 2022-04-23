import SwiftUI

struct Upload: View {
    
    @State var show = false
    @State var alert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Document picker")
                }
                .sheet(isPresented: $show) {
                    DocumentPicker(alert: self.$alert)
                }
                
                Button(action: {
                    
                }) {
                    Text("Send")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.indigo)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $alert) {
                    Alert(title: Text("Message"), message: Text("Uploaded Successfully!!!"), dismissButton: .default(Text("Ok")))
                }
            }
        } .padding()
    }
}

struct Upload_Previews: PreviewProvider {
    static var previews: some View {
        Upload()
    }
}
