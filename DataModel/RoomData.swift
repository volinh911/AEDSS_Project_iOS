//
//  RoomData.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 20/04/2023.
//

import Foundation

struct RoomData: Codable, Identifiable {
	let id = UUID()
	let uniqueRoom: [String]
}
