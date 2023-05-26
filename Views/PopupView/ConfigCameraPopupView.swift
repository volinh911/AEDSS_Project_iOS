//
//  ConfigCameraPopupView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 02/05/2023.
//

import SwiftUI

struct ConfigCameraPopupView: View {
	@State var receivedConfig = "1"
	@State var chosen = 1
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@EnvironmentObject var configAndScheduleSettings: ConfigAndScheduleSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	@Binding var nameRoom: String
	
	@EnvironmentObject private var mqttManager: MQTTManager
	
	var body: some View {
		VStack{
			Text("Camera's Frequency Check")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(Color.buttonColor)
			// line
			Rectangle()
				.fill(.black)
				.frame(height: 1)
			Text("The system will check every \(receivedConfig) hour(s)")
				.font(.custom("Inconsolata-Regular", size: 15))
				.foregroundColor(Color.onColor)
				.multilineTextAlignment(.center)
				.padding(.top, 10)
			Text("How often do you want the camera to check the room?")
				.font(.custom("Inconsolata-Regular", size: 12))
				.foregroundColor(Color.backgroundColor)
				.multilineTextAlignment(.center)
				.padding(.top, 10)
			Picker("", selection: $chosen) {
				ForEach(1..<24, id: \.self){
					Text("\($0)")
				}
			}
			.pickerStyle(.wheel)
			
			Button(action: {
				print("\(chosen)")
				let parameters: [String: Any] = ["userID": savedUserId, "room": nameRoom, "loopTime": String(chosen)]
				configAndScheduleSettings.postConfig(auth: savedAuth, userid: savedUserId, parameters: parameters)
				receivedConfig = String(chosen)
				if !mqttManager.isConnected() {
					connectMQTT()
				}
				publish()
			}) {
				Text("OK")
					.font(.custom("Inconsolata-Regular", size: 18))
					.padding([.horizontal],30)
					.padding([.vertical], 10)
					.background(Color.buttonColor)
					.foregroundColor(.white)
					.cornerRadius(8)
			}
			
		}.padding()
			.background(Color.white)
			.cornerRadius(15)
			.onAppear(perform: {
				getStart()
			})
	}
	
	func getStart(){
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		configAndScheduleSettings.getConfig(auth: savedAuth, userid: savedUserId, roomName: nameRoom)
		receivedConfig = UserDefaults.standard.string(forKey: settings.CAMERA_CONFIG) ?? "1"
	}
	func connectMQTT() {
		mqttManager.initializeMQTT(host: mqttInfo.BROKER, identifier: UUID().uuidString)
		mqttManager.connect()
	}
	private func publish() {
		let topic = "scheduler/server"
		let request = "config:\(nameRoom)@\(savedUserId)"
		if (mqttManager.isConnected()) {
			mqttManager.publish(topic: topic, with: request)
		}
	}
}

//struct ConfigCameraPopupView_Previews: PreviewProvider {
//	static var previews: some View {
//		ConfigCameraPopupView(nameRoom: .constant("G2"))
//	}
//}
