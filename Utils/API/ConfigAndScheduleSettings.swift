//
//  ConfigAndScheduleSettings.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 18/05/2023.
//

import Foundation

class ConfigAndScheduleSettings: ObservableObject {
	
	func getConfig(auth: String, userid: String, roomName: String) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.GET_CONFIG_API + roomName) else {
			print("Not found URL")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, red, error) in if error != nil {
				print("error api getConfig", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ConfigData.self, from: data)
					DispatchQueue.main.async {
						if result._id != nil {
							UserDefaults.standard.set(result.loopTime, forKey: settings.CAMERA_CONFIG)
						}
					}
				}
			} catch let JsonError {
				print("getConfig error:", JsonError)
				return
			}
		}.resume()
	}
	
	func postConfig(auth: String, userid: String, parameters: [String: Any]) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.POST_CONFIG_API) else {
			print("Not found URL")
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
				print("error post config", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async {
						print("New config: \(result)")
					}
				} else {
					print("cannot post new config")
					return
				}
			} catch let JsonError {
				print("post config error:", JsonError)
				return
			}
		}.resume()
	}
}
