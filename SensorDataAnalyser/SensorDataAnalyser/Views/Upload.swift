import SwiftUI
import Alamofire

struct UploadResponse : Decodable {
    let success : Bool
}

struct Upload: View {
    
    @State var show = false
    @State var alert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    
    @State var selectedFileUrl: String = ""
    @State var selectedFileName: String = ""
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(" \(selectedFileName)")
                    .multilineTextAlignment(TextAlignment.center)
                    .padding(.bottom)
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Select file")
                }
                .sheet(isPresented: $show) {
                    DocumentPicker(alert: self.$alert, selectedFileURL: self.$selectedFileUrl, selectedFileName: self.$selectedFileName)
                }
                
                Button(action: {
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(URL(string: selectedFileUrl)!, withName: "file")
                    }, to: "http://localhost:8080/upload")
                    .responseDecodable(of: UploadResponse.self) { response in
                        
                        if (response.value?.success == true) {
                            alertTitle = "Message"
                            alertMessage = "File uploaded successfully!"
                            alert = true
                        } else {
                            alertTitle = "Message"
                            alertMessage = "Wrong file type. Please upload only .json files!"
                            alert = true
                        }
                        
                    }
                    selectedFileName = ""
                    selectedFileUrl = ""
                }) {
                    Text("Upload file")
                        .padding()
                }
                .disabled(selectedFileUrl.isEmpty ? true : false)
                .alert(isPresented: $alert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                }
                
            } .padding()
        }
    }
}
