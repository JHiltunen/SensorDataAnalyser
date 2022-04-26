//
//  ResponseTest.swift
//  SensorDataAnalyser
//
//  Created by Jon Menna on 22.4.2022.
//

import Foundation
import SwiftUI



/*

// MARK: - MovesenseAcceleration
struct MovesenseAcceleration: Codable {
    let data: [DataElement]

    enum CodingKeys: String, CodingKey {
        case data = "data:"
    }
}

// MARK: - DataElement
struct DataElement: Codable {
    let acc: Acc
}

// MARK: - Acc
struct Acc: Codable {
    let timestamp: Int
    let arrayAcc: [ArrayAcc]

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case arrayAcc = "ArrayAcc"
    }
}

// MARK: - ArrayAcc
struct ArrayAcc: Codable {
    let x, y, z: Double
}
 */

// MARK: - MovesenseAcceleration
struct MovesenseAcceleration: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let acc: Acc
}

// MARK: - Acc
struct Acc: Codable {
    let timestamp: Int
    let arrayAcc: [ArrayAcc]

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case arrayAcc = "ArrayAcc"
    }
}

// MARK: - ArrayAcc
struct ArrayAcc: Codable {
    let x, y, z: Double
}

