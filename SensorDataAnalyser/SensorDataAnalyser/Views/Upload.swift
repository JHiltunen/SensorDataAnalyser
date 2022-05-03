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
    
    @State var selectedFileUrls: [String] = []
    @State var selectedFileNames: [String] = []
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                let string = selectedFileNames.joined(separator: ", ")
                Text("\(string)")
                
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Select file")
                        .font(.title2)
                }
                .sheet(isPresented: $show) {
                    DocumentPicker(alert: self.$alert, selectedFileUrls: self.$selectedFileUrls, selectedFileNames: self.$selectedFileNames)
                }
                
                Button(action: {
                    AF.upload(multipartFormData: { multipartFormData in
                        selectedFileUrls.forEach { fileUrl in
                            multipartFormData.append(URL(string: fileUrl)!, withName: "files")
                        }
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
                    selectedFileNames = [""]
                    selectedFileUrls = [""]
                }) {
                    Text("Upload file")
                        .padding()
                        .font(.title3)
                }
                .disabled(selectedFileUrls.isEmpty ? true : false)
                .alert(isPresented: $alert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                }
                
            } .padding()
        }
    }
}
