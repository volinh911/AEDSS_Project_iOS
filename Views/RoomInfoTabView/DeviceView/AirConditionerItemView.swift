//
//  AirConditionerItemView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 01/05/2023.
//

import SwiftUI

struct AirConditionerItemView: View {
	@Binding var acOn: Bool
	@Binding var currentTemp: String
	
	@State var showPowerPopup = false
	var body: some View {
		VStack {
			HStack(alignment: .top) {
				Image(systemName: "air.conditioner.horizontal")
					.font(.system(size: 20))
					.foregroundColor(.white)
					.padding(.leading, 20)
					.padding(.top, 5)
				Text("Air Conditioner")
					.font(.custom("Inconsolata-Regular", size: 20))
					.foregroundColor(.white)
					.padding(.top, 7)
					.padding(.leading, 10)
				Spacer()
				Button(action: {
					self.showPowerPopup.toggle()
					
				}) {
					Image(systemName: "togglepower")
						.font(.system(size: 22))
						.foregroundColor(.white)
						.padding(.trailing, 20)
						.padding(.top, 10)
				}
				
			}
			HStack {
				Text("Current Temperature: \(currentTemp)")
					.font(.custom("Inconsolata-Regular", size: 15))
					.foregroundColor(.white)
					.padding(.top, 1)
					.padding(.leading, 65)
				Spacer()
			}
			AsyncImage(
				url: URL(string: "\(other.IMG_URL)10pr-BL5MglDqDts6XiZSM_RMdzZpzl64"),
				content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
				},
				placeholder: {
					ProgressView()
				}
			)

			if self.showPowerPopup {
				GeometryReader { geometry in
					VStack {
						ACPopupPower()
					}.frame(maxWidth: .infinity, maxHeight: .infinity)
				}.background(Color.black.opacity(0.65)
					.edgesIgnoringSafeArea(.all)
					.onTapGesture {
						withAnimation{
							self.showPowerPopup.toggle()
						}
					})
			}
		}
		.background(Color.backgroundColor)
		.padding(.top, 20)
	}
}

//struct AirConditionerItemView_Previews: PreviewProvider {
//	static var previews: some View {
//		AirConditionerItemView(acOn: .constant(true), currentTemp: 26)
//	}
//}
