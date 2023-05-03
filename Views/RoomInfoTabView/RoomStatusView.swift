//
//  RoomStatusView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 23/04/2023.
//

import SwiftUI

struct RoomStatusView: View {
	@State private var lightOn = false
	@State private var acOn = false
	@State private var doorClosed = false
	
	@State private var isDoor = false
	@State private var isAC = false
	@State private var isLight = false
	@State private var isYolo = false
	
	@EnvironmentObject private var mqttManager: MQTTManager
	
	var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			// main screen
			VStack {
				//door
				DoorItemView(doorClosed: $doorClosed)
				
				// gallery
				GalleryItemView()
				
				// light
				LightItemView(lightOn: $lightOn)
				
				// AC
				AirConditionerItemView(acOn: $acOn)
				
				Spacer()

			}
			Spacer()
		}
	}
	
	func connectMQTT() {
		mqttManager.initializeMQTT(host: mqttInfo.BROKER, identifier: UUID().uuidString)
		mqttManager.connect()
	}
	
	func disconnectMQTT() {
		mqttManager.disconnect()
	}
}

//struct RoomStatusView_Previews: PreviewProvider {
//	static var previews: some View {
//		RoomStatusView()
//	}
//}
