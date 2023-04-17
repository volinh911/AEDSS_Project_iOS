//
//  Authentication.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 11/04/2023.
//

import Foundation
import SwiftUI

class AuthenticationAPI: ObservableObject {
	
	func postLoginUser(parameters: [String: Any]) -> Bool {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.POST_LOGIN_API) else {
			print("Not found URL")
			return false
		}
				
		let data = try! JSONSerialization.data(withJSONObject: parameters)
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = data
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		var isValid = false
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(ResponseData.self, from: data)
					DispatchQueue.main.async{
						if (result.success == true) {
							print(result)
							isValid = true
						} else {
							print("false")
							print(result)
							return
						}
					}
				} else {
					print("No data")
					return
				}
			} catch let JsonError {
				print("post user error:", JsonError)
				return
			}
		}.resume()
		
		return isValid
		
	}
}
