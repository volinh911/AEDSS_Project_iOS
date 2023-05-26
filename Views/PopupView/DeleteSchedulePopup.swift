//
//  DeleteSchedulePopup.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 26/05/2023.
//

import SwiftUI

struct DeleteSchedulePopup: View {
    var body: some View {
		VStack{
			Text("Alert")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(Color.buttonColor)

			// line
			Rectangle()
				.fill(.black)
				.frame(height: 1)
			
			Text("Are you sure you wish to delete?")
				.font(.custom("Inconsolata-Regular", size: 15))
				.foregroundColor(Color.black)
			
			HStack {
				Button(action: {
					
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
    }
}

struct DeleteSchedulePopup_Previews: PreviewProvider {
    static var previews: some View {
        DeleteSchedulePopup()
    }
}
