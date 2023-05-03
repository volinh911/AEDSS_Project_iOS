//
//  DoorItemView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 01/05/2023.
//

import SwiftUI

struct DoorItemView: View {
	@Binding var doorClosed: Bool
	@State private var iconKey = ""
	
    var body: some View {
		// door
		HStack(alignment: .top) {
			Image(systemName: "door.left.hand.closed")
				.font(.system(size: 20))
				.foregroundColor(.white)
				.padding(.leading, 20)
				.padding(.top, 5)
			Text("Door")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(.white)
				.padding(.top, 5)
				.padding(.leading, 18)
			Spacer()
			Image(systemName: self.iconKey)
				.font(.system(size: 20))
				.foregroundColor(.white)
				.padding(.trailing, 20)
				.padding(.top, 5)
		}.background(Color.backgroundColor)
			.padding(.top, 20)
			.onAppear(perform: {
				getIconKey()
			})
    }
	
	func getIconKey() {
		if !doorClosed {
			self.iconKey = "lock"
		} else {
			self.iconKey = "lock.open"
		}
	}
}

struct DoorItemView_Previews: PreviewProvider {
    static var previews: some View {
		DoorItemView(doorClosed: .constant(true))
    }
}
