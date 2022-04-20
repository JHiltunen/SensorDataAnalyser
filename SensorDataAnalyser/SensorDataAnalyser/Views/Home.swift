import SwiftUI

struct Home: View {
    
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    // Flexible, custom amount of columns that fill the remaining space
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Adaptive, make sure it's the size of your smallest element.
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    // Fixed, creates columns with fixed dimensions
    private let fixedColumns = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                            Text("\(month)")
                                .foregroundColor(.white)
                                .font(.system(size: 20, design: .rounded))
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
