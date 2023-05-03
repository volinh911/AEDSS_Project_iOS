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
			print("Not found URL getRoomList")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, res, error) in if error != nil {
				print("error api getRoomList", error?.localizedDescription ?? "")
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
	
	func getCamera(auth: String, userid: String, roomName: String) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.GET_YOLO_DETAIL_API + roomName) else {
			print("Not found URL")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, red, error) in if error != nil {
				print("error api getYolo", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode([CameraData].self, from: data)
					DispatchQueue.main.async {
						if result[0]._id != nil {
							print("have yolo - camera")
							UserDefaults.standard.set(true, forKey: settings.HAVE_CAMERA)
						} else {
							print("dont have yolo - camera")
							UserDefaults.standard.set(false, forKey: settings.HAVE_CAMERA)
						}
					}
				}
			} catch let JsonError {
				print("get yolo error:", JsonError)
				return
			}
		}.resume()
	}
	
	func getAllDevices(auth: String, userid: String, roomName: String) {
		guard let url = URL(string: apiInfo.BASE_URL_API + apiInfo.GET_ALL_DEVICES_API + roomName) else {
			print("Not found URL")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue(auth, forHTTPHeaderField: "auth")
		request.setValue(userid, forHTTPHeaderField: "userid")
		
		URLSession.shared.dataTask(with: request) {
			(data, red, error) in if error != nil {
				print("error api getYolo", error?.localizedDescription ?? "")
				return
			}
			
			do {
				if let data = data {
					let result = try JSONDecoder().decode([DeviceData].self, from: data)
					DispatchQueue.main.async {
						if result != nil {
							var deviceList = [String]()
							for device in result {
								let publish = device.topic.publish
								if (publish != nil) {
									// subscribe topic for ac and light
									if publish!.contains(deviceName.CAMERA_PACK) {
										// subscribe topic for ac
										UserDefaults.standard.set(publish, forKey: settings.AC_SUBSCRIBE_TOPIC)
										print("AC_SUBSCRIBE_TOPIC: \(publish ?? "")")
										// subscribe topic for light
										UserDefaults.standard.set(publish, forKey: settings.LIGHT_SUBSCRIBE_TOPIC)
										print("LIGHT_SUBSCRIBE_TOPIC: \(publish ?? "")")
									}
									// subscribe topic for door
									else if publish!.contains(deviceName.DOOR_DEVICE) {
										UserDefaults.standard.set(publish, forKey: settings.DOOR_SUBSCRIBE_TOPIC)
										print("DOOR_SUBSCRIBE_TOPIC: \(publish ?? "")")
									}
									// topic to send request for ac and light
									else if publish!.contains(deviceName.AC_DEVICE) {
										UserDefaults.standard.set(publish, forKey: settings.LIGHT_AC_REQUEST_TOPIC)
										print("LIGHT_AC_REQUEST_TOPIC: \(publish ?? "")")
									}
								}
								
								
								let subscribe = device.topic.subscribe
								if (subscribe != nil) {
									// publish topic for ac and light
									if subscribe!.contains(deviceName.CAMERA_PACK) {
										// publish topic for ac
										UserDefaults.standard.set(subscribe, forKey: settings.AC_PUBLISH_TOPIC)
										print("AC_PUBLISH_TOPIC: \(subscribe ?? "")")
										// publish topic for light
										UserDefaults.standard.set(subscribe, forKey: settings.LIGHT_PUBLISH_TOPIC)
										print("LIGHT_PUBLISH_TOPIC: \(subscribe ?? "")")
									}
									// publish topic for door
									else if subscribe!.contains(deviceName.DOOR_DEVICE) {
										UserDefaults.standard.set(subscribe, forKey: settings.DOOR_PUBLISH_TOPIC)
										print("DOOR_PUBLISH_TOPIC: \(subscribe ?? "")")
									}
								}
								
								for tempFunc in device.function {
									if (tempFunc.contains(deviceName.DOOR_DEVICE)) {
										deviceList.append(tempFunc)
									}
									else if (tempFunc.contains(deviceName.AC_DEVICE)) {
										deviceList.append(tempFunc)
									}
									else if (tempFunc.contains(deviceName.LIGHT_STATE)) {
										deviceList.append(tempFunc)
									}
								}
							}
							UserDefaults.standard.set(deviceList, forKey: settings.DEVICE_LIST)
							print("deviceList: \(UserDefaults.standard.object(forKey: settings.DEVICE_LIST) as? [String] ?? [])")
						} else {
							print("no result for device")
						}
					}
				}
			} catch let JsonError {
				print("get yolo error:", JsonError)
				return
			}
		}.resume()
	}
}
