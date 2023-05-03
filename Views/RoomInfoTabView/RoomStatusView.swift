//
//  RoomStatusView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 23/04/2023.
//

import SwiftUI

struct RoomStatusView: View {
	// boolean for status device
	@State var lightOn = false
	@State var acOn = false
	@State var doorClosed = false
	@State var currentTemp = 0
	
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@EnvironmentObject var roomSettings: RoomSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	@State var savedRoomName = ""
	@State var haveCamera = false
	@State var haveAc = false
	@State var haveDoor = false
	@State var haveLight = false
	
	@State var doorSubscribeTopic = ""
	@State var lightSubscribeTopic = ""
	@State var acSubscribeTopic = ""
	@State var doorPublishTopic = ""
	@State var lightPublishTopic = ""
	@State var acPublishTopic = ""
	
	@State var ac_lightRequestTopic = ""
	@State var topic: String = ""
	
	@EnvironmentObject private var mqttManager: MQTTManager
	
	var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			// main screen
			VStack {
				if self.haveDoor {
					//door
					DoorItemView(doorClosed: $doorClosed)
				}
				
				if self.haveCamera {
					// gallery
					GalleryItemView()
				}
				if self.haveLight {
					// light
					LightItemView(lightOn: $lightOn)
				}
				if self.haveAc {
					// AC
					AirConditionerItemView(acOn: $acOn, currentTemp: $currentTemp)
				}
				
				Spacer()

			}
			Spacer()
		}.onAppear(perform: {
			if !mqttManager.isConnected() {
				connectMQTT()
			}
			getNeccessaryInfo()
		})
	}
	
	func getNeccessaryInfo() {
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		haveCamera = UserDefaults.standard.bool(forKey: settings.HAVE_CAMERA)
		savedRoomName = UserDefaults.standard.string(forKey: settings.ROOM_NAME) ?? ""

		
		doorPublishTopic = UserDefaults.standard.string(forKey: settings.DOOR_PUBLISH_TOPIC) ?? ""
		doorSubscribeTopic = UserDefaults.standard.string(forKey: settings.DOOR_SUBSCRIBE_TOPIC) ?? ""
		
		acSubscribeTopic = UserDefaults.standard.string(forKey: settings.AC_SUBSCRIBE_TOPIC) ?? ""
		acPublishTopic = UserDefaults.standard.string(forKey: settings.AC_PUBLISH_TOPIC) ?? ""
		
		lightPublishTopic = UserDefaults.standard.string(forKey: settings.LIGHT_PUBLISH_TOPIC) ?? ""
		lightSubscribeTopic = UserDefaults.standard.string(forKey: settings.LIGHT_SUBSCRIBE_TOPIC) ?? ""
		
		ac_lightRequestTopic = UserDefaults.standard.string(forKey: settings.LIGHT_AC_REQUEST_TOPIC) ?? ""
		
		let deviceList: [String] = UserDefaults.standard.object(forKey: settings.DEVICE_LIST) as? [String] ?? []
		print("mqttState: \(mqttManager.currentAppState.appConnectionState)")
		print("mqtt isConnected: \(mqttManager.isConnected())")
		for device in deviceList {
			if device.contains(deviceName.AC_DEVICE) {
				haveAc = true
				if (mqttManager.isConnected()) {
					subscribe(topic: acSubscribeTopic)
				}
			}
			else if device.contains(deviceName.DOOR_DEVICE) {
				haveDoor = true
				if (mqttManager.isConnected()) {
					subscribe(topic: doorSubscribeTopic)
				}
			}
			else if device.contains(deviceName.LIGHT_STATE) {
				haveLight = true
				if (mqttManager.isConnected()) {
					subscribe(topic: doorSubscribeTopic)
				}
			}
		}
		
		publish(topic: acPublishTopic, request: mqttInfo.REQUEST_AC_STATE)
		publish(topic: doorPublishTopic, request: mqttInfo.REQUEST_DOOR)
		publish(topic: lightPublishTopic, request: mqttInfo.REQUEST_LIGHT_STATE)
	}
	
	func connectMQTT() {
		mqttManager.initializeMQTT(host: mqttInfo.BROKER, identifier: UUID().uuidString)
		mqttManager.connect()
	}
	
	func disconnectMQTT() {
		mqttManager.disconnect()
	}
	
	private func subscribe(topic: String) {
		mqttManager.subscribe(topic: topic)
	}
	
	private func publish(topic: String, request: String) {
		mqttManager.publish(topic: topic, with: request)
	}
}

//struct RoomStatusView_Previews: PreviewProvider {
//	static var previews: some View {
//		RoomStatusView()
//	}
//}
