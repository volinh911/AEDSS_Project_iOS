//
//  GalleryItemView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 01/05/2023.
//

import SwiftUI

struct GalleryItemView: View {
	var body: some View {
		HStack(alignment: .top) {
			Image(systemName: "folder")
				.font(.system(size: 20))
				.foregroundColor(.white)
				.padding(.leading, 20)
				.padding(.top, 5)
			Text("Gallery")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(.white)
				.padding(.top, 5)
				.padding(.leading, 10)
			Spacer()
			Image(systemName: "chevron.right")
				.font(.system(size: 15))
				.foregroundColor(.white)
				.padding(.trailing, 20)
				.padding(.top, 10)
		}.background(Color.backgroundColor)
			.padding(.top, 20)
	}
}

struct GalleryItemView_Previews: PreviewProvider {
	static var previews: some View {
		GalleryItemView()
	}
}
