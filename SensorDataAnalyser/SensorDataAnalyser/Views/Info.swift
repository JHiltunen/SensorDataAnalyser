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



struct Info: View {
    
    
    @State private var redNumber: Double = 0.0
    @State private var orangeNumber: Double = 0.0
    @State private var redString: String = ""
    @State private var orangeString: String = ""
    @State private var input: String = ""
    @State private var output: String = ""
    @AppStorage("orange") private var orange = 0.1
    @AppStorage("red") private var red = 0.5
    
    @State private var buttonText: String = "Change"
    
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                ZStack {
                    Rectangle()
                        .frame(minWidth: 200, minHeight: 130)
                        .foregroundColor(.white)
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
                        .frame(minWidth: 200, minHeight: 130)
                        .foregroundColor(.yellow)
                        .cornerRadius(15)
                    
                    VStack{
                        VStack {
                            TextField("Insert new value for orange", text: $orangeString) {
                                orangeNumber = Double(orangeString) ?? 0.1
                            }
                                .keyboardType(.decimalPad)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.2))
                            TextField("Insert new value for red", text: $redString){
                                redNumber = Double(redString) ?? 0.1
                            }
                                .keyboardType(.decimalPad)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.2))
                        
                        }.padding()
                        if (redNumber < orangeNumber) {
                            Text("Red must be bigger than orange!")
                        }
                        
                        if redString != "" && orangeString != ""{
                            Button ( action: {
                                //self.showAlert.toggle()
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



