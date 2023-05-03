//
//  ConfigCameraPopupView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 02/05/2023.
//

import SwiftUI

struct ConfigCameraPopupView: View {
	@State var chosen = 1
	var body: some View {
		VStack{
			Text("Camera's Frequency Check")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(Color.buttonColor)
			// line
			Rectangle()
				.fill(.black)
				.frame(height: 1)
			Text("How often do you want the camera to check the room?")
				.font(.custom("Inconsolata-Regular", size: 15))
				.foregroundColor(Color.backgroundColor)
				.multilineTextAlignment(.center)
			Picker("", selection: $chosen) {
				ForEach(1..<24, id: \.self){
					Text("\($0)")
				}
			}
			.pickerStyle(.wheel)
			
			Button(action: {
				print("\(chosen)")
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
	}
}

struct ConfigCameraPopupView_Previews: PreviewProvider {
	static var previews: some View {
		ConfigCameraPopupView()
	}
}
