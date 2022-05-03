import SwiftUI

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct Threshold: View {
    
    @State private var redNumber: Double = 0.0
    @State private var orangeNumber: Double = 0.0
    @State private var redString: String = ""
    @State private var orangeString: String = ""
    @State private var input: String = ""
    @State private var output: String = ""
    @AppStorage("orange") private var orange = 0.1
    @AppStorage("red") private var red = 0.5
    
    @State private var buttonText: String = "Change"
    
    @FocusState private var values: Bool
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: 350, maxHeight: 100)
                        .foregroundColor(.indigo)
                        .cornerRadius(15)
                    
                    VStack {
                        Text("Orange level: \(String(orange)) ")
                            .frame(maxWidth: .infinity, minHeight: 10)
                            .foregroundColor(.orange)
                            .padding(.top)
                            .font(.system(size: 20, design: .rounded))
                        
                        Text("Red level: \(String(red))")
                            .frame(maxWidth: .infinity, minHeight: 10)
                            .foregroundColor(.red)
                            .padding(.bottom)
                            .font(.system(size: 20, design: .rounded))
                    }
                }.padding()

                ZStack {
                    Rectangle()
                        .frame(maxWidth: 350, maxHeight: 300)
                        .foregroundColor(Color.indigo)
                        .cornerRadius(15)
                    
                    VStack{
                        Text("Insert values")
                            .font(.title2)
                            .foregroundColor(.white)
                        VStack {
                            TextField("Insert new value for orange", text: $orangeString) {
                                orangeNumber = Double(orangeString) ?? 0.1
                            }
                                .keyboardType(.decimalPad)
                                .font(.title2)
                                .padding(.bottom)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: 290, maxHeight: 20)
                            
                            TextField("Insert new value for red", text: $redString){
                                redNumber = Double(redString) ?? 0.1
                            }
                                .keyboardType(.decimalPad)
                                .font(.title2)
                                .textFieldStyle(.roundedBorder)
                                .focused($values)
                                .frame(maxWidth: 290, maxHeight: 50)
                        }
                        .padding()
                        
                        if (redNumber < orangeNumber) {
                            Text("Red must be bigger than orange!")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        
                        if redString != "" && orangeString != ""{
                            Button ( action: {
                                orangeNumber = Double(orangeString) ?? 0.1
                                redNumber = Double(redString) ?? 0.1
                                if redNumber > orangeNumber {
                                    orange = orangeNumber
                                    red = redNumber
                                    orangeString = ""
                                    redString = ""
                                } else {
                                    orangeString = ""
                                    redString = ""
                                }
                                values = false
                            }, label: {
                                Text(buttonText)
                                    .foregroundColor(.gray)
                            })
                            .buttonStyle(.borderedProminent)
                            .padding()
                        }
                    }
                }.padding()
            }
        }
    }
}



