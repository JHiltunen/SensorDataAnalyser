import SwiftUI
import Foundation
import MobileCoreServices
import UniformTypeIdentifiers

// tutorial: https://www.youtube.com/watch?v=q8y_eRVfpMA
struct DocumentPicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return DocumentPicker.Coordinator(parent1: self)
    }
    
    @Binding var alert : Bool
    @Binding var selectedFileUrls : [String]
    @Binding var selectedFileNames : [String]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController  {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.json])
        picker.allowsMultipleSelection = true;
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        uiViewController.allowsMultipleSelection = true
    }
    
    class Coordinator : NSObject, UIDocumentPickerDelegate {
        
        var parent : DocumentPicker
        
        //let serverUrl = "https://sensordataanalyserbackend.azurewebsites.net/"
        let serverUrl = "http://localhost:8080/"
        
        init(parent1 : DocumentPicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            urls.forEach {parent.selectedFileUrls.append($0.absoluteString)}
            
            parent.selectedFileUrls.forEach { url in
                var urlSeparatedBySlash = url.components(separatedBy: "/")
                parent.selectedFileNames.append(urlSeparatedBySlash[urlSeparatedBySlash.count - 1])
            }
        }
        
    }
}
