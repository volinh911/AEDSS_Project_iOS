//
//  ACPopupPower.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 26/05/2023.
//

import SwiftUI

struct ACPopupPower: View {
	@Environment(\.dismiss) private var dismiss
    var body: some View {
		VStack{
			Text("Alert")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(Color.buttonColor)

			// line
			Rectangle()
				.fill(.black)
				.frame(height: 1)
			
			Text("What do you want to do with AC?")
				.font(.custom("Inconsolata-Regular", size: 15))
				.foregroundColor(Color.black)
			
			HStack {
				Button(action: {
					
				}) {
					Text("Turn on")
						.font(.custom("Inconsolata-Regular", size: 15))
						.padding([.horizontal],30)
						.padding([.vertical], 10)
						.background(Color.onColor)
						.foregroundColor(.black)
						.cornerRadius(8)
				}
				
				Button(action: {
					
				}) {
					Text("Turn off")
						.font(.custom("Inconsolata-Regular", size: 15))
						.padding([.horizontal],30)
						.padding([.vertical], 10)
						.background(Color.offColor)
						.foregroundColor(.white)
						.cornerRadius(8)
				}
				
				Button(action: {
					dismiss()
				}) {
					Text("Cancel")
						.font(.custom("Inconsolata-Regular", size: 15))
						.padding([.horizontal],30)
						.padding([.vertical], 10)
						.background(Color.black)
						.foregroundColor(.white)
						.cornerRadius(8)
				}
				
			}
		}.padding()
			.background(Color.white)
			.cornerRadius(15)
    }
}

struct ACPopupPower_Previews: PreviewProvider {
    static var previews: some View {
        ACPopupPower()
    }
}
