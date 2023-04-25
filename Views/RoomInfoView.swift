//
//  RoomInfoView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 22/04/2023.
//

import SwiftUI

struct RoomInfoView: View {
	@State var roomName = ""
	let room: RoomModel
	
	var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			VStack {
				// taskbar
				HStack {
					Image(systemName: "gearshape.fill")
						.font(.system(size: 20))
						.foregroundColor(.white)
						.padding(.leading, 20)
						.padding(.top, 8)
					Spacer()
					Text("Room \(self.roomName)")
						.font(.custom("Inconsolata-Regular", size: 30))
						.foregroundColor(.white)
					Spacer()
					Image(systemName: "plus")
						.font(.system(size: 20))
						.foregroundColor(.white)
						.padding(.trailing, 20)
				}
				
				// line
				Rectangle()
					.fill(.black)
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
		}.toolbar(.hidden)
		.onAppear(perform: {
			self.roomName = room.name
		})
	}
	
}

//struct RoomInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomInfoView()
//    }
//}
