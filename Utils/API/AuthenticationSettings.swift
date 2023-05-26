//
//  AuthenticationSettings.swift
//  AEDSS_Project_iOS
//	This class is created to connect API for login and saved cache for login
//  Created by vtlinh on 10/04/2023.
//

import Foundation

class AuthenticationSettings: ObservableObject {
	@Published var isLoggedIn: Bool {
		didSet {
			UserDefaults.standard.set(isLoggedIn, forKey: settings.IS_LOGGED_IN)
		}
	}
	@Published var haveEmail: Bool {
		didSet {
			UserDefaults.standard.set(isLoggedIn, forKey: settings.HAVE_EMAIL)
		}
	}
	@Published var isToken: Bool {
		didSet {
			UserDefaults.standard.set(isLoggedIn, forKey: settings.HAVE_EMAIL)
		}
	}
	@Published var auth: String {
		didSet {
			UserDefaults.standard.set(auth, forKey: settings.AUTH)
		}
	}
	@Published var userid: String {
		didSet {
			UserDefaults.standard.set(userid, forKey: settings.USERID)
		}
	}
	init() {
		self.isLoggedIn = false
		self.auth = ""
		self.userid = ""
		self.haveEmail = false
		self.isToken = false
	}
	
	func postLoginUser(parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.POST_LOGIN_API) else {
			print("Not found URL postLoginUser")
			return
		}
		
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async{
						print("API login: \(result)")
						if (result.success == true) {
							if let response = res as? HTTPURLResponse {
								self.userid = response.value(forHTTPHeaderField: "userid")!
								print("userid: \(self.userid)")
								self.auth = response.value(forHTTPHeaderField: "auth")!
								print("auth: \(self.auth)")
								self.isLoggedIn = true
							}
						} else {
							return
						}
					}
				} else {
					print("No data for user")
					return
				}
			} catch let JsonError {
				print("post user error:", JsonError)
				return
			}
		}.resume()
	}
	
	func checkEmail(parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.CHECK_EMAIL_API) else {
			print("Not found URL postLoginUser")
			return
		}
		
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async {
						print("Check email: \(result)")
						if (result.success == true) {
							self.haveEmail = true
							self.sendToken(parameters: parameters)
						}
					}
				} else {
					print("no email")
					return
				}
			} catch let JsonError {
				print("check email error:", JsonError)
				return
			}
		}.resume()
	}
	
	func sendToken(parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.SEND_TOKEN_API) else {
			print("Not found URL postLoginUser")
			return
		}
		
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async {
						print("Send token: \(result)")
					}
				} else {
					print("no token")
					return
				}
			} catch let JsonError {
				print("send token error:", JsonError)
				return
			}
		}.resume()
	}
	
	func validateToken(parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.VALIDATE_TOKEN_API) else {
			print("Not found URL postLoginUser")
			return
		}
		
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async {
						print("Validate token: \(result)")
						if (result.success == true) {
							if let response = res as? HTTPURLResponse {
								self.userid = response.value(forHTTPHeaderField: "userid")!
								print("userid: \(self.userid)")
								self.auth = response.value(forHTTPHeaderField: "auth")!
								print("auth: \(self.auth)")
								self.isToken = true
							}
						} else {
							return
						}
					}
				} else {
					print("cannot validate token")
					return
				}
			} catch let JsonError {
				print("validate token error:", JsonError)
				return
			}
		}.resume()
	}
	
	func changePassword(auth: String, userid: String, parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.CHANGE_PASS_API) else {
			print("Not found URL postLoginUser")
			return
		}
		
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async {
						print("Validate token: \(result)")
						if (result.success == true) {
							if let response = res as? HTTPURLResponse {
								self.userid = response.value(forHTTPHeaderField: "userid") ?? ""
								print("userid: \(self.userid)")
								self.auth = response.value(forHTTPHeaderField: "auth") ?? ""
								print("auth: \(self.auth)")
								self.isLoggedIn = true
							}
						} else {
							return
						}
					}
				} else {
					print("cannot validate token")
					return
				}
			} catch let JsonError {
				print("validate token error:", JsonError)
				return
			}
		}.resume()
	}
}
