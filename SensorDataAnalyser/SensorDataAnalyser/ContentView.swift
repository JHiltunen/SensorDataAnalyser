import SwiftUI



struct ContentView: View {
    var body: some View {
        TabView {
         
                Home()
                // .navigationBarTitle("Data Analyzer")
         
            
            .tabItem {
                SwiftUI.Image(systemName: "house")
                Text("Home")
            }
            Upload()
                .tabItem {
                    SwiftUI.Image(systemName: "icloud.and.arrow.up")
                    Text("Upload")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
