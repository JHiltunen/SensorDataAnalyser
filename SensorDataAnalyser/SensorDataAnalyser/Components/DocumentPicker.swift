import SwiftUI
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers
import Alamofire

// tutorial: https://www.youtube.com/watch?v=q8y_eRVfpMA
struct DocumentPicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    @Binding var alert : Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController  {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.json])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    struct Root : Decodable {
        let data : [String]
    }
    class Coordinator : NSObject, UIDocumentPickerDelegate {
        
        var parent : DocumentPicker
        
        //let serverUrl = "https://sensordataanalyserbackend.azurewebsites.net/"
        let serverUrl = "http://localhost:8080/"
        
        init(parent1 : DocumentPicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            let fileUrl = urls[0]
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(fileUrl, withName: "file")
            }, to: "\(serverUrl)upload")
            //https://sensordataanalyserbackend.azurewebsites.net/
            //http://localhost:8080/upload
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
        }
    }
}
