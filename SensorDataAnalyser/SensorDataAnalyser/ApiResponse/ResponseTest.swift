import Foundation
import SwiftUI

struct MovesenseAcceleration: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let acc: Acc
}

struct Acc: Codable {
    let timestamp: Int
    let arrayAcc: [ArrayAcc]

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case arrayAcc = "ArrayAcc"
    }
}

struct ArrayAcc: Codable {
    let x, y, z: Double
}

