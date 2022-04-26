import Foundation

/*
func totalAcceleration (sensorNumber: Int) -> Double {
    let moveSensei: MovesenseAcceleration = load("testDataSensei\(sensorNumber).json")
    var sum = 0.0
    for i in 1...moveSensei.data.count {
        let x = moveSensei.data[i - 1].acc.arrayAcc[0].x
        let z = moveSensei.data[i - 1].acc.arrayAcc[0].z
        let y = moveSensei.data[i - 1].acc.arrayAcc[0].y
        
        let sqrtXZ = sqrt(x*x + z*z)
        let accXYZ = sqrt(y*y + sqrtXZ)
        sum += accXYZ
    }
    return sum / Double(moveSensei.data.count)
}
 */
