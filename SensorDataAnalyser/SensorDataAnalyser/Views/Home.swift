import SwiftUI
import Foundation

struct Home: View {
    
    @State private var results = Response()
    @State private var resultsMonth = ResponseMonth()
    @State private var results2 = [Datum]()
    @State private var sum: Double = 0.0
    @State private var averageAll: Double = 0.0
    @State private var aveRage: Double = 0.0
    @State private var reCent: Double = 0.0
    
    @State private var numero: Int = 0
    @State private var totalAverage: Double = 0.0
    @State private var monthAverage: Double = 0.0
    
    @State private var setColor: Color = Color.black
    
    @AppStorage("tapCount") private var tapCount = 0
    @AppStorage("orange") private var orange = 0.1
    @AppStorage("red") private var red = 0.5
    
    let serverUrl = "https://sensordataanalyserbackend.azurewebsites.net/"
    //let serverUrl = "http://localhost:8080/"
    
    func loadData(searchAdress: String) async {
        guard let url = URL(string: searchAdress) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ResponseAll.self, from: data) {
                aveRage = decodedResponse
            } else {
                print("Invalid data 1")
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    func loadRecentAverage(searchAdress: String) async {
        guard let url = URL(string: searchAdress) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ResponseAll.self, from: data) {
                reCent = decodedResponse
            } else {
                print("Invalid data 1")
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    func loadMonthData(searchAdress: String) async {
        guard let url = URL(string: searchAdress) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let monthlyData = try? JSONDecoder().decode(ResponseMonth.self, from: data){
                var amountOfData = 0.0
                
                for i in 1...monthlyData.count {
                    if monthlyData[String(i)]!.count > 0  {
                        amountOfData += 1
                        let jorma = (monthlyData[String(i)]?[0] ?? 0) * 1.0
                        sum += jorma
                        averageAll = sum / amountOfData
                    }
                }
                
            } else {
                print("Invalid data 1")
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    func loadMonthDataForGrid(searchAdress: String, month: String) async {
        var monthNumber: Int = 1
        let month = month
        
        switch month {
        case "January":
            monthNumber = 1
        case "February":
            monthNumber = 2
        case "March":
            monthNumber = 3
        case "April":
            monthNumber = 4
        case "May":
            monthNumber = 5
        case "June":
            monthNumber = 6
        case "July":
            monthNumber = 7
        case "August":
            monthNumber = 8
        case "September":
            monthNumber = 9
        case "October":
            monthNumber = 10
        case "November":
            monthNumber = 11
        case "December":
            monthNumber = 12
        default:
            monthNumber = 1
        }
        
        guard let url = URL(string: searchAdress) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let monthlyData = try? JSONDecoder().decode(ResponseMonth.self, from: data){
                var totalSum = 0.0
                var control = 0.0
                resultsMonth = monthlyData
                
                if monthlyData[String(monthNumber)]!.count > 0  {
                    monthAverage = (monthlyData[String(monthNumber)]?[0] ?? 0) * 1.0
                    totalSum += monthAverage
                    control += 1
                }
                if control > 0 {
                    totalAverage = totalSum / control
                    control = 0
                }
            } else {
                print("Invalid data 1")
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    func monthToNumber(month: String) -> Int {
        
        let month = month
        
        switch month {
        case "January":
            return 1
        case "February":
            return 2
        case "March":
            return  3
        case "April":
            return  4
        case "May":
            return  5
        case "June":
            return  6
        case "July":
            return  7
        case "August":
            return  8
        case "September":
            return  9
        case "October":
            return  10
        case "November":
            return  11
        case "December":
            return 12
        default:
            return 1
        }
    }
    
    func deviationToColor(deviation: Double) -> Color {
        
        let deviation = deviation
        
        switch deviation {
        case 0...orange:
            return .green
        case  orange...red:
            return .orange
        case  red...100:
            return  .red
        default:
            return .white
        }
    }
    
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    // Adaptive, make sure it's the size of your smallest element.
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                Text("Total average:\(String(format: "%.5f", aveRage))")
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.bottom)
                    .font(.system(size: 20, design: .rounded))
                    .task  {
                        //await loadData(searchAdress: "http://localhost:8080/files/allAverage/")
                        await loadData(searchAdress: "\(serverUrl)files/allAverage/")
                    }
                
                ZStack {
                    Rectangle()
                        .frame(maxWidth: 350, minHeight: 150)
                        .foregroundColor(deviationToColor(deviation: abs(reCent - aveRage)))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                
                    VStack {
                        Text("Most recent average: \(String(format: "%.5f", reCent))")
                            .frame(maxWidth: 350, minHeight: 70)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .font(.system(size: 20, design: .rounded))
                            .task {
                                await loadRecentAverage(searchAdress: "\(serverUrl)files/recent/")
                            }
                        HStack {
                            Text("Deviation |last  - average|:\n\(String(format: "%.5f", abs(reCent - aveRage)))")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.system(size: 20, design: .rounded))
                                .task {
                                    await loadRecentAverage(searchAdress: "\(serverUrl)files/recent/")
                                    await loadData(searchAdress: "\(serverUrl)files/allAverage/")
                                }
                            
                            if (reCent - aveRage) < 0 {
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                            } else if (reCent - aveRage) > 0 {
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                            } else {
                                Image(systemName: "arrow.left.and.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40))
                            }
                        }
                    }
                }.padding(.bottom)
                
                LazyVGrid(columns: adaptiveColumns) {
                    ForEach(months, id: \.self) { month in
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.indigo)
                                .cornerRadius(15)
                            
                            VStack {
                                Text("\(month)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, design: .rounded))
                                if ((resultsMonth[String(monthToNumber(month: month))]?[0] ?? 0.0)) == 0 {
                                    Text("-")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, design: .rounded))
                                        .task {
                                            //await loadMonthDataForGrid(searchAdress: "http://localhost:8080/files/monthDataMath/", month: month)
                                            await loadMonthDataForGrid(searchAdress: "\(serverUrl)files/monthDataMath/", month: month)
                                            
                                        }
                                } else {
                                    Text("\(resultsMonth[String(monthToNumber(month: month))]?[0] ?? 0.0)")
                                        .foregroundColor((deviationToColor(deviation: abs((resultsMonth[String(monthToNumber(month: month))]?[0] ?? 0.0) - aveRage))))
                                        .font(.system(size: 20, design: .rounded))
                                        .task {
                                            //await loadMonthDataForGrid(searchAdress: "http://localhost:8080/files/monthDataMath/", month: month)
                                            await loadMonthDataForGrid(searchAdress: "\(serverUrl)files/monthDataMath/", month: month)
                                            
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
