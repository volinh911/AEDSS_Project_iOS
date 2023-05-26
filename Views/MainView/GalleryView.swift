//
//  GalleryView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 05/05/2023.
//

import SwiftUI

struct GalleryView: View {
	@Environment(\.dismiss) private var dismiss
	
	private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
	
	private var imgList_1 = ["1KJRnMmecYmoIi6sXVG0g5HqIR9fmS9Gl", "1h8m5XlmZmKGsgGTO-WRGB-v3FKdX-1S6"]
	
	private var imgList_2 = ["1G4Ex3qKfextt-otVNK1vc6kizcrZiSkA", "1r_XvpCKNHfqq0YJfojGGjJVL0e8KLc1W", "1yPZzznQ5qVEBgQ3KJJRFEJCzQqCPjWvD", "1q5uxVTbwAVJ1J6enrExBsIhT4r4LztqX", "1jiTAvCO37N6x_y8gZZVNHbztCenpcPRv"]
	
	@State private var showImage = false
	@State private var currentImg = ""
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					// taskbar
					Text("Gallery")
						.font(.custom("Inconsolata-Bold", size: 30))
						.foregroundColor(.white)
						.padding(.leading, 20)
					
					// line
					Rectangle()
						.fill(Color.lineColor)
						.frame(height: 1)
					
					ScrollView {
						Section(header: Text("14/05/2023"), content: {})
							.frame(maxWidth: .infinity, alignment: .leading)
							.padding(.leading, 20)
							.foregroundColor(.white)
							.font(.custom("Inconsolata-Regular", size: 18))
						
						LazyVGrid(columns: gridItemLayout, spacing: 20) {
							ForEach(imgList_1, id: \.self) { img in
								Button(action: {
									self.showImage = true
									self.currentImg = img
								}, label: {
									AsyncImage(
										url: URL(string: "\(other.IMG_URL)\(img)"),
										content: { image in
											image.resizable()
												.aspectRatio(contentMode: .fit)
										},
										placeholder: {
											ProgressView()
										}
									).cornerRadius(15)
										.padding(.leading, 5)
								})
							}
						}
						
						Section(header: Text("13/05/2023"), content: {})
							.frame(maxWidth: .infinity, alignment: .leading)
							.padding(.leading, 20)
							.foregroundColor(.white)
							.font(.custom("Inconsolata-Regular", size: 18))
						
						LazyVGrid(columns: gridItemLayout, spacing: 20) {
							ForEach(imgList_2, id: \.self) { img in
								Button(action: {
									self.showImage = true
									self.currentImg = img
								}, label: {
									AsyncImage(
										url: URL(string: "\(other.IMG_URL)\(img)"),
										content: { image in
											image.resizable()
												.aspectRatio(contentMode: .fit)
										},
										placeholder: {
											ProgressView()
										}
									).cornerRadius(15)
										.padding(.leading, 5)
								})
							}
						}
					}
					
				}
			}
			Spacer()
		}.popover(isPresented: $showImage) {
			AsyncImage(
				url: URL(string: "\(other.IMG_URL)\(self.currentImg)"),
				content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fit)
				},
				placeholder: {
					ProgressView()
				}
			)
		}
		.navigationTitle("")
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
						Text("Room Info")
							.font(.custom("Inconsolata-Regular", size: 20))
							.foregroundColor(.offColor)
					}
				}
			}
		}
	}
	
	
}

struct GalleryView_Previews: PreviewProvider {
	static var previews: some View {
		GalleryView()
	}
}
