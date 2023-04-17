//
//  AuthenticationSettings.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 10/04/2023.
//

import Foundation

class AuthenticationSettings: ObservableObject {
	@Published var isLoggedIn: Bool {
		didSet {
			UserDefaults.standard.set(isLoggedIn, forKey: "login")
		}
	}
	@Published var auth: String {
		didSet {
			UserDefaults.standard.set(auth, forKey: "auth")
		}
	}
	@Published var userid: String {
		didSet {
			UserDefaults.standard.set(userid, forKey: "auth")
		}
	}
	init() {
		self.isLoggedIn = false
		self.auth = ""
		self.userid = ""
	}
 }
