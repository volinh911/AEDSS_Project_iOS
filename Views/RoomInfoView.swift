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
					Text("Room List")
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
				
				Spacer()
			}
		}.navigationBarHidden(true)
	}
	
}

//struct RoomInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomInfoView()
//    }
//}
