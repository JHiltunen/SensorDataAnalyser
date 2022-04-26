import SwiftUI
import Alamofire

struct Root : Decodable {
    let data : [String]
}

struct Upload: View {
    
    @State var show = false
    @State var alert = false
    @State var selectedFileUrl: String = ""
    @State var selectedFileName: String = ""
    
    var body: some View {
       
            VStack {
                Text("Selected file: \(selectedFileName)")
                    .multilineTextAlignment(TextAlignment.center)
                    .padding()
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Document picker")
                }
                .sheet(isPresented: $show) {
                    DocumentPicker(alert: self.$alert, selectedFileURL: self.$selectedFileUrl, selectedFileName: self.$selectedFileName)
                }
                
                Button(action: {
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(URL(string: selectedFileUrl)!, withName: "file")
                    }, to: "http://localhost:8080/upload")
                        .responseDecodable(of: Root.self) { response in
                            debugPrint(response)
                        }
                        .uploadProgress { progress in
                            print("Upload Progress: \(progress.fractionCompleted)")
                        }
                        .downloadProgress { progress in
                            print("Download Progress: \(progress.fractionCompleted)")
                        }
                        .responseDecodable(of: Root.self) { response in
                            debugPrint(response)
                        }
                }) {
                    Text("Send")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                }
                .disabled(selectedFileUrl.isEmpty ? true : false)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Message"), message: Text("Uploaded Successfully!!!"), dismissButton: .default(Text("Ok")))
                }
            
        } .padding()
    }
}
