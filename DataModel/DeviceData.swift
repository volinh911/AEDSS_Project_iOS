//
//  DeviceData.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 11/04/2023.
//

import Foundation
import SwiftUI

struct DeviceData: Decodable {
	let _id: String
	let deviceName: String
	let room: String
	let deviceModule: String
	let function: [String]
	let topic: TopicData
	let ack: AckData
	let request: RequestData
	let pin: PinData
}

struct AckData: Decodable {
	let door: String?
	let pir: String?
	let ac: String?
	let light: String?
	let lightState: String?
	let temp: String?
	let servo: String?
}

struct PinData: Decodable {
	let door: Int?
	let pir: Int?
}

struct RequestData: Decodable {
	let door: String?
	let pir: String?
	let api: String?
	let acOn: String?
	let acOff: String?
	let lightOn: String?
	let lightOff: String?
	let temp: String?
	let lightState: String?
	let servo: String?
}

struct TopicData: Decodable {
	let subscribe: String?
	let ack: String?
	let publish: String?
}
