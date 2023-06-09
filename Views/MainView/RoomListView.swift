//
//  RoomListView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 10/04/2023.
//

import SwiftUI

struct RoomListView: View {
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@EnvironmentObject var roomSettings: RoomSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	@State var showLogoutPopup = false
	@State var roomList = [RoomModel]()
	
	@EnvironmentObject private var mqttManager: MQTTManager
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					// taskbar
					HStack {
						NavigationLink(destination: ChangePasswordView()) {
							Image(systemName: "person.fill")
								.font(.system(size: 20))
								.foregroundColor(.white)
								.padding(.leading, 20)
								.padding(.top, 8)
						}
						
						Spacer()
						Text("Room List")
							.font(.custom("Inconsolata-Bold", size: 30))
							.foregroundColor(.white)
						Spacer()
						Button(action: {
							self.showLogoutPopup.toggle()
						}, label: {
							Image(systemName: "arrowshape.turn.up.right")
								.font(.system(size: 20))
								.foregroundColor(.white)
								.padding(.trailing, 20)
						})
					}
					
					// line
					Rectangle()
						.fill(.black)
						.frame(height: 1)
					
					// list room
					List(roomList) { room in
						HStack(alignment: .top) {
							Image(systemName: "door.left.hand.closed")
								.font(.system(size: 20))
								.foregroundColor(.white)
							Text("Room \(room.name)")
								.font(.custom("Inconsolata-Regular", size: 20))
								.padding(.top, 3)
								.foregroundColor(.white)
							Spacer()
							Image(systemName: "chevron.right")
								.font(.system(size: 10))
								.foregroundColor(.white)
								.padding(.top, 10)
						}.listRowBackground(Color.backgroundColor)
							.padding(.top, 5)
							.background(
								NavigationLink(destination: RoomInfoView(room: room).environmentObject(MQTTManager.shared())) {
								}.opacity(0))
					}.scrollContentBackground(.hidden)
						.background(Color.backgroundColor)
						.listStyle(.plain)
				}
				// to push everything top
				Spacer()
				
				if self.showLogoutPopup {
					GeometryReader { geometry in
						VStack {
							VStack{
								Text("Alert")
									.font(.custom("Inconsolata-Regular", size: 20))
									.foregroundColor(Color.buttonColor)
								
								// line
								Rectangle()
									.fill(.black)
									.frame(height: 1)
								
								Text("Are you sure you wish to logout?")
									.font(.custom("Inconsolata-Regular", size: 15))
									.foregroundColor(Color.black)
								
								HStack {
									Button(action: {
										mqttManager.disconnect()
										authenticationSettings.isLoggedIn = false
									}) {
										Text("OK")
											.font(.custom("Inconsolata-Regular", size: 18))
											.padding([.horizontal],30)
											.padding([.vertical], 10)
											.background(Color.buttonColor)
											.foregroundColor(.white)
											.cornerRadius(8)
									}
									
								}
							}.padding()
								.background(Color.white)
								.cornerRadius(15)
						}.frame(maxWidth: .infinity, maxHeight: .infinity)
					}.background(Color.black.opacity(0.65)
						.edgesIgnoringSafeArea(.all)
						.onTapGesture {
							withAnimation{
								self.showLogoutPopup.toggle()
							}
						})
				}
			}
		}.onAppear(perform: {onStart()})
			.accentColor(Color.backgroundColor)
	}
	
	func onStart() {
		getHeaders()
		getListRoom()
		connectMQTT()
	}
	
	func getHeaders(){
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		print("auth: \(savedAuth)")
		print("userid: \(savedUserId)")
	}
	
	func getListRoom() {
		roomSettings.getRoomList(auth: savedAuth, userid: savedUserId)
		let listRoom: [String] = UserDefaults.standard.object(forKey: settings.ROOM_LIST) as? [String] ?? []
		for room in listRoom {
			roomList.append(RoomModel(name: room))
		}
	}
	
	func connectMQTT() {
		mqttManager.initializeMQTT(host: mqttInfo.BROKER, identifier: UUID().uuidString)
		mqttManager.connect()
	}
}

//struct RoomListView_Previews: PreviewProvider {
//	static var previews: some View {
//		RoomListView()
//	}
//}
