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
    @Binding var selectedFileURL : String
    @Binding var selectedFileName : String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController  {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.json])
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        
    }
    
    class Coordinator : NSObject, UIDocumentPickerDelegate {
        
        var parent : DocumentPicker
        
        init(parent1 : DocumentPicker) {
            parent = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)
            let fileUrl = urls[0]
            
            parent.selectedFileURL = fileUrl.absoluteString
            let lastIndex = fileUrl.absoluteString.lastIndex(of: "/")
            parent.selectedFileName = String(fileUrl.absoluteString.suffix(from: fileUrl.absoluteString.index(lastIndex!, offsetBy: 1)))
        }
        
    }
}
