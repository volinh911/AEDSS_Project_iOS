//
//  ResponseData.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 11/04/2023.
//

import Foundation
import SwiftUI

struct ResponseData: Decodable{
	let success: Bool?
	let info: String?
	let error: String?
}
