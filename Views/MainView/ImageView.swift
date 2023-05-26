//
//  ImageView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 05/05/2023.
//

import SwiftUI

struct ImageView: View {
	@Environment(\.dismiss) private var dismiss
	
	@Binding var url: String
	var body: some View {
		
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					// taskbar
					HStack {
						Text("Image View")
							.font(.custom("Inconsolata-Bold", size: 30))
							.foregroundColor(.white)
							.padding(.leading, 20)
						Spacer()
					}
					
					// line
					Rectangle()
						.fill(Color.lineColor)
						.frame(height: 1)
					
					Spacer()
					
					AsyncImage(
						url: URL(string: "\(other.IMG_URL)\(url)"),
						content: { image in
							image.resizable()
								.aspectRatio(contentMode: .fit)
						},
						placeholder: {
							ProgressView()
						}
					)
					Spacer()
					
				}
				
			}.navigationTitle("")
				.navigationBarBackButtonHidden(true)
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button {
							dismiss()
						} label: {
							HStack {
								Image(systemName: "chevron.backward")
									.font(.system(size: 13))
									.foregroundColor(.offColor)
									.padding(.top, 5)
									.padding(.trailing, 20)
								Text("Gallery")
									.font(.custom("Inconsolata-Regular", size: 20))
									.foregroundColor(.offColor)
							}
						}
					}
				}
		}
	
	}
}

struct ImageView_Previews: PreviewProvider {
	static var previews: some View {
		ImageView(url: .constant("1KJRnMmecYmoIi6sXVG0g5HqIR9fmS9Gl"))
	}
}

