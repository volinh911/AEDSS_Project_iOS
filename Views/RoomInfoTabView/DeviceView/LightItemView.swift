//
//  LightItemView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 01/05/2023.
//

import SwiftUI

struct LightItemView: View {
	@Binding var lightOn: Bool
	var body: some View {
		HStack(alignment: .top) {
			Image(systemName: "light.cylindrical.ceiling.inverse")
				.font(.system(size: 20))
				.foregroundColor(.white)
				.padding(.leading, 20)
				.padding(.top, 5)
			Text("Light")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(.white)
				.padding(.top, 7)
				.padding(.leading, 14)
			Spacer()
			Toggle("", isOn: $lightOn)
				.toggleStyle(SwitchToggleStyle(tint: .green))
				.padding(.trailing, 20)
				.font(.system(size: 10))
		}.background(Color.backgroundColor)
			.padding(.top, 20)
	}
}

struct LightItemView_Previews: PreviewProvider {
	static var previews: some View {
		LightItemView(lightOn: .constant(true))
	}
}
