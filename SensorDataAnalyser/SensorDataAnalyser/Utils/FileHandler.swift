import SwiftUI

func getFile(fileName: String) -> [UInt8]? {
    // See if the file exists.
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(fileName)
        do {
            // Get the raw data from the file.
            let rawData: Data = try Data(contentsOf: fileURL)
            // Return the raw data as an array of bytes.
            return [UInt8](rawData)
        } catch {
            // Couldn't read the file.
            return nil
        }
    }
    print("\(fileName) not exist")
    return nil
}
func uploadFile(fileName: String, fileExtension: String, endpoint: String) {
    let fileNameWithExtension = fileName + "." + fileExtension
    let url = URL(string: endpoint)
    
    var data = Data()
    
    // generate boundary string using a unique per-app string
    let boundary = UUID().uuidString
    
    let session = URLSession.shared
    
    // Set the URLRequest to POST and to the specified URL
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "POST"
    
    // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
    // And the boundary is also set here
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    // Add the file data to the raw http request data
    // data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    //    data.append("Content-Disposition: form-data; name=\"name\"; username=\"kemal\"\r\n".data(using: .utf8)!)
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"file\"; filename=\"recieved\(fileExtension)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: \"content-type header\"\r\n\r\n".data(using: .utf8)!)
    
    print("opening file...")
    if let bytes: [UInt8] = getFile(fileName: fileNameWithExtension) {
        for byte in bytes {
            data.append(byte)
        }
        
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
}
