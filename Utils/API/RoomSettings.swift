//
//  RoomSettings.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 20/04/2023.
//

import Foundation

class RoomSettings: ObservableObject {
	
	func getRoomList(auth: String, userid: String) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.GET_ALL_ROOMS_API) else {
			print("Not found URL")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api login", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode(RoomData.self, from: data)
					DispatchQueue.main.async{
						if result.uniqueRoom != nil {
							print("can load room")
							print("\(result.uniqueRoom)")
							let roomList: [String] = result.uniqueRoom
							UserDefaults.standard.set(roomList, forKey: settings.ROOM_LIST)
						} else {
							print("no list room")
							return
						}
						
					}
				} else {
					print("No data for room")
					return
				}
			} catch let JsonError {
				print("get room error:", JsonError)
				return
			}
		}.resume()
		
		
	}
}
