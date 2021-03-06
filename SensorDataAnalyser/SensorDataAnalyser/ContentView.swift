import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color(.black)) // custom color.
      }
    
    var body: some View {
        TabView {
                Home()
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            Upload()
                .tabItem {
                    Image(systemName: "icloud.and.arrow.up")
                    Text("Upload")
                }
            Threshold()
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("Threshold")
                }
        } .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
