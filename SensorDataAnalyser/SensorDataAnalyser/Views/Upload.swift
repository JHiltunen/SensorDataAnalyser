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
        Text("Data Analyzer")
            .font(.title)
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
                    selectedFileName = ""
                    selectedFileUrl = ""
                }) {
                    Text("Upload file")
                        .padding()
                }
                .disabled(selectedFileUrl.isEmpty ? true : false)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Message"), message: Text("File uploaded"), dismissButton: .default(Text("Ok")))
                }
                
            } .padding()
        }
        }
    }
}
