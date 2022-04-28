import SwiftUI

struct Home: View {
    
    @State private var Avg: Int = 0
    
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    
//    // Flexible, custom amount of columns that fill the remaining space
//    private let numberColumns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
    
    // Adaptive, make sure it's the size of your smallest element.
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Text("Deviation")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .padding(.bottom)
                        .font(.system(size: 20, design: .rounded))
                    
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(months, id: \.self) { month in
                            ZStack {
                                Rectangle()
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(.indigo)
                                    .cornerRadius(15)
                                VStack {
                                    Text("\(month)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 25, design: .rounded))
                                        .padding(.bottom)
                                    Text("Avg: \(String(Avg))")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, design: .rounded))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Data Analyzer")
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
