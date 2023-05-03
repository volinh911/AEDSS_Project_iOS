//
//  CameraData.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 02/05/2023.
//

import Foundation

//struct CameraData: Codable {
//	let data: [Camera]?
//}

struct CameraData: Codable {
	let _id: String?
	let subscribe: String?
	let publish: String?
	let room: String?
	let request: [String]?
}
