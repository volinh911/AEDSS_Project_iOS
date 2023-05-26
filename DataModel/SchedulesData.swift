//
//  SchedulesData.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 05/05/2023.
//

import Foundation

struct SchedulesData: Decodable {
	let _id: String?
	let deviceName: String?
	let deviceModule: String?
	let room: String?
	let dayOfTheWeek: String?
	let timeOn: String?
	let timeOff: String?
	let rerun: String?
	let request: String?
}
