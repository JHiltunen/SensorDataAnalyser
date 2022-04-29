import SwiftUI
import Foundation




struct Home: View {
    
    // let response = try? newJSONDecoder().decode(Response.self, from: jsonData)
    
    @State private var results = Response()
    @State private var resultsMonth = ResponseMonth()
    @State private var results2 = [Datum]()
    @State private var aikaLeima: Int = 0
    @State private var sum: Double = 0.0
    @State private var averageAll: Double = 0.0
    @State private var aveRage: Double = 0.0
    @State private var reCent: Double = 0.0
    
    @State private var numero: Int = 0
    @State private var totalAverage: Double = 0.0
    @State private var monthAverage: Double = 0.0
    @State private var monthAverage1: Double = 0.0
    @State private var monthAverage2: Double = 0.0
    @State private var monthAverage3: Double = 0.0
    @State private var monthAverage4: Double = 0.0
    @State private var monthAverage5: Double = 0.0
    @State private var monthAverage6: Double = 0.0
    @State private var monthAverage7: Double = 0.0
    @State private var monthAverage8: Double = 0.0
    @State private var monthAverage9: Double = 0.0
    @State private var monthAverage10: Double = 0.0
    @State private var monthAverage11: Double = 0.0
    @State private var monthAverage12: Double = 0.0
    
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
                //if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                //                for result in decodedResponse {
                //                    DispatchQueue.main.async {}
                //                }
                aveRage = decodedResponse
                //results = decodedResponse
                print(aveRage)
                //print(results)
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
            print("MONTA KERTAA RECENT?!!!!!!!!!!!!!!!!!!!")
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(ResponseAll.self, from: data) {
                //if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                //                for result in decodedResponse {
                //                    DispatchQueue.main.async {}
                //                }
                reCent = decodedResponse
                //results = decodedResponse
                print(reCent)
                //print(results)
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
            print("MONTA KERTAA MONTHDATA?????")
            let (data, _) = try await URLSession.shared.data(from: url)
            if let monthlyData = try? JSONDecoder().decode(ResponseMonth.self, from: data){
                //print(monthlyData["4"]?[0])
                
                //var jorma = (monthlyData["4"]?[0] ?? 9999) * 3
                //print(jorma)
                //var sum = 0.0
                var amountOfData = 0.0
                print("MONTHLY DATA COUNT",monthlyData.count)
                
                for i in 1...monthlyData.count {
                    print("MONTHLY DATA STRING COUNT", monthlyData[String(i)]!.count)
                    if monthlyData[String(i)]!.count > 0  {
                        //print(monthlyData[String(i)])
                        amountOfData += 1
                        let jorma = (monthlyData[String(i)]?[0] ?? 0) * 1.0
                        //print("JORMA", jorma)
                        sum += jorma
                        averageAll = sum / amountOfData
                        print("SUMMA", averageAll, sum, amountOfData)
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
        
        print("CASEN KUUKAUSI: ", month)
        
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
            print("MONTA KERTAA?????")
            let (data, _) = try await URLSession.shared.data(from: url)
            if let monthlyData = try? JSONDecoder().decode(ResponseMonth.self, from: data){
                //print(monthlyData["4"]?[0])
                
                //var jorma = (monthlyData["4"]?[0] ?? 9999) * 3
                //print(jorma)
                var totalSum = 0.0
                var control = 0.0
                resultsMonth = monthlyData
                
                if monthlyData[String(monthNumber)]!.count > 0  {
                    //print(monthlyData[String(i)])
                    monthAverage = (monthlyData[String(monthNumber)]?[0] ?? 0) * 1.0
                    print("CASEN MONTH AVERAGE: ", monthAverage, monthNumber)
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
    
    
    
    
    func loadSpecificData(searchAdress: String) async {
        guard let url = URL(string: searchAdress) else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let movesenseAcceleration = try? JSONDecoder().decode(MovesenseAcceleration.self, from: data){
                //
                results2 = movesenseAcceleration.data
                
                for i in 1...results2.count {
                    let x = results2[i - 1].acc.arrayAcc[0].x
                    let z = results2[i - 1].acc.arrayAcc[0].z
                    let y = results2[i - 1].acc.arrayAcc[0].y
                    
                    let sqrtXZ = sqrt(x*x + z*z)
                    let accXYZ = sqrt(y*y + sqrtXZ)
                    sum += accXYZ
                }
                aveRage = sum / Double(results2.count)
                aikaLeima = (results2[0].acc.timestamp)
                print("AARGH!!!",results2[0].acc.timestamp)
            } else {
                print("Invalid data 1")
            }
        } catch {
            print("Error info: \(error)")
        }
    }
    
    func monthToNumber(month: String) -> Int {
        
        let month = month
        
        print("CASEN KUUKAUSI: ", month)
        
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
    // Kunnon datalla:
    
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
    
    
    func deviationToColor2(deviation: Double) -> Color {
        
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
    
    /*
     // Joonaksen datalla
     func deviationToColor(deviation: Double) -> Color {
     
     let deviation = deviation
     
     switch deviation {
     case 0...2:
     return .green
     case  2...2.8:
     return .orange
     case  2.8...100:
     return  .red
     default:
     return .white
     }
     }
     
     
     func deviationToColor2(deviation: Double) -> Color {
     
     let deviation = deviation
     
     switch deviation {
     case 0...2:
     return .green
     case  2...2.8:
     return .orange
     case  2.8...100:
     return  .red
     default:
     return .white
     }
     }
     */
    
    
    private let monthsWithNumber = ["January": 1, "February": 2, "March" : 3, "April": 4, "May": 5, "June": 6, "July": 7, "August": 8, "September": 9, "October": 10, "November": 11, "December": 12]
    
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
    
    //Memory test stuff
    //@State private var tapCount = 0
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
            
                Text("Total average:\(String(aveRage))")
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
                        .frame(width: .infinity, height: 170)
                        .foregroundColor(deviationToColor(deviation: abs(reCent - aveRage)))
                        .cornerRadius(15)
                
                    VStack{
                        Text("Most recent average: \(String(reCent))")
                            .frame(maxWidth: .infinity, minHeight: 70)
                        
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        
                            .font(.system(size: 20, design: .rounded))
                            .task {
                                await loadRecentAverage(searchAdress: "\(serverUrl)files/recent/")
                                
                            }
                        HStack {
                            Text("Deviation |last  - average|: \(String(abs(reCent - aveRage)))")
                                .foregroundColor(.white)
                                .font(.system(size: 20, design: .rounded))
                                .task {
                                    await loadRecentAverage(searchAdress: "\(serverUrl)files/recent/")
                                    await loadData(searchAdress: "\(serverUrl)files/allAverage/")
                                }
                            
                            if (reCent - aveRage) < 0 {
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.white)
                                    .font(.system(size: 45))
                            } else if (reCent - aveRage) > 0 {
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.white)
                                    .font(.system(size: 45))
                            } else {
                                Image(systemName: "arrow.left.and.right")
                                    .foregroundColor(.white)
                                    .font(.system(size: 45))
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
                                        .foregroundColor((deviationToColor2(deviation: abs((resultsMonth[String(monthToNumber(month: month))]?[0] ?? 0.0) - aveRage))))
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
            .navigationTitle("Data Analyzer")
            .padding()
            //.navigationBarHidden(true)
        }
    }
    
    
}
