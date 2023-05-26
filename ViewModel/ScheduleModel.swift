//
//  ScheduleModel.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 25/05/2023.
//

import Foundation

struct ScheduleModel: Identifiable {
	let id = UUID()
	let scheduleId: String
	let day: String
	let isAC: Bool
	let isRepeat: Bool
	let from: String
	let to: String
}
