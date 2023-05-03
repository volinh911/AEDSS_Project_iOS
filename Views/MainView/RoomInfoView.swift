//
//  RoomInfoView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 22/04/2023.
//

import SwiftUI

struct RoomInfoView: View {
	@Environment(\.dismiss) private var dismiss
	
	@State private var roomName = ""
	let room: RoomModel
	
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@EnvironmentObject var roomSettings: RoomSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	
	@State var haveCamera = false
	@EnvironmentObject private var mqttManager: MQTTManager
	
	@State var showConfigCameraPopup = false
	
	var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			VStack {
				// taskbar
				HStack {
					Text("Room \(self.roomName)")
						.font(.custom("Inconsolata-Bold", size: 30))
						.foregroundColor(.white)
						.padding(.leading, 20)
					Spacer()
				}
				
				// line
				Rectangle()
					.fill(Color.lineColor)
					.frame(height: 1)
				
				// Bottom navigation
				TabView {
					// Tab Status
					RoomStatusView().tabItem{
						Label("status", systemImage: "togglepower")
					}.toolbar(.visible, for: .tabBar)
						.toolbarBackground(Color.backgroundColor, for: .tabBar)
					
					// Tab List
					RoomTimeListView().tabItem{
						Label("list", systemImage: "clock")
					}.toolbar(.visible, for: .tabBar)
						.toolbarBackground(Color.backgroundColor, for: .tabBar)
					
				}.tint(Color.white)
				
				Spacer()
			}
			
			if self.showConfigCameraPopup {
				GeometryReader { geometry in
					VStack {
						ConfigCameraPopupView()
					}.frame(maxWidth: .infinity, maxHeight: .infinity)
				}.background(Color.black.opacity(0.65)
					.edgesIgnoringSafeArea(.all)
					.onTapGesture {
						withAnimation{
							self.showConfigCameraPopup.toggle()
						}
					})
			}
		}.onAppear(perform: {
			self.roomName = room.name
			getHeaders()
		})
		.navigationTitle("")
		.navigationBarBackButtonHidden(true)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button {
					print("Custom Action")
					// 2
					dismiss()
					
				} label: {
					HStack {
						Image(systemName: "chevron.backward")
							.font(.system(size: 13))
							.foregroundColor(.offColor)
							.padding(.top, 5)
							.padding(.trailing, 20)
						Text("Room List")
							.font(.custom("Inconsolata-Regular", size: 20))
							.padding(.top, 5)
							.foregroundColor(.offColor)
					}
				}
			}
			
			ToolbarItem(placement: .navigationBarTrailing) {
				HStack {
					if (self.haveCamera) {
						Button(action: {
							self.showConfigCameraPopup.toggle()
							
						}) {
							Image(systemName: "gearshape.fill")
								.font(.system(size: 13))
								.foregroundColor(.offColor)
								.padding(.top, 8)
								.padding(.trailing, 15)
						}
					}
					
					Button{
						
					} label: {
						Image(systemName: "plus")
							.font(.system(size: 13))
							.foregroundColor(.offColor)
							.padding(.trailing, 10)
							.padding(.top, 8)
					}
				}
				
			}
		}
		
	}
	
	func getHeaders(){
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		print("auth roominfo: \(savedAuth)")
		print("userid roominfo: \(savedUserId)")
		checkCamera()
	}
	func checkCamera() {
		roomSettings.getCamera(auth: savedAuth, userid: savedUserId, roomName: room.name)
		haveCamera = UserDefaults.standard.bool(forKey: settings.HAVE_CAMERA)
		print("haveCamera roominfo: \(haveCamera)")
	}
}

//struct RoomInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//		RoomInfoView(room: RoomModel(name: "G2")).environmentObject(MQTTManager.shared())
//    }
//}
