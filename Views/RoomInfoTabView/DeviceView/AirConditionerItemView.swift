//
//  AirConditionerItemView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 01/05/2023.
//

import SwiftUI

struct AirConditionerItemView: View {
	@Binding var acOn: Bool
	var body: some View {
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
			Toggle("", isOn: $acOn)
				.toggleStyle(SwitchToggleStyle(tint: .green))
				.padding(.trailing, 20)
				.font(.system(size: 10))
		}.background(Color.backgroundColor)
			.padding(.top, 20)
	}
}

struct AirConditionerItemView_Previews: PreviewProvider {
	static var previews: some View {
		AirConditionerItemView(acOn: .constant(true))
	}
}
