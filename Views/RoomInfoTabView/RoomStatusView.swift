//
//  RoomStatusView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 23/04/2023.
//

import SwiftUI

struct RoomStatusView: View {
    var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			// main screen
			VStack {
				// gallery
				HStack(alignment: .top) {
					Image(systemName: "folder")
						.font(.system(size: 20))
						.foregroundColor(.white)
						.padding(.leading, 20)
					Text("Gallery")
						.font(.custom("Inconsolata-Regular", size: 20))
						.foregroundColor(.white)
						.padding(.top, 5)
					Spacer()
				}
			}
			
			Spacer()
		}
    }
}

struct RoomStatusView_Previews: PreviewProvider {
    static var previews: some View {
        RoomStatusView()
    }
}
