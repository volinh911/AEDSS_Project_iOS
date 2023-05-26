//
//  EditScheduleView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 25/05/2023.
//

import SwiftUI

struct EditScheduleView: View {
	@Environment(\.dismiss) private var dismiss
	
	@State private var selected = 1
	@State private var isAC = true
	@State private var isRepeat = false
	@State private var isFrom = false
	@State private var isTo = false
	@State private var chosenDay = "Monday"
	@State private var chosenTimeFrom = 0
	@State private var chosenTimeTo = 0
	@State private var chosenMinFrom = 0
	@State private var chosenMinTo = 0
	
	@State var showDeletePopup = false
	
	private var dayOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					// taskbar
					Text("Edit Schedule")
						.font(.custom("Inconsolata-Bold", size: 25))
						.foregroundColor(.white)
						.padding(.leading, 20)
					
					Text("Choose Device")
						.font(.custom("Inconsolata-Regular", size: 18))
						.foregroundColor(.white)
						.padding(.top, 10)
						.padding(.leading, 10)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					HStack{
						Button(action: {isAC = true}) {
							Text(" ")
								.frame(width: 15, height: 15)
								.background(isAC ? Color.buttonColor : Color.white)
								.cornerRadius(50)
								.foregroundColor(.black)
								.padding()
								.overlay(RoundedRectangle(cornerRadius: 50)
									.stroke(.black, lineWidth: 3)
									.scaleEffect(0.4))
							Text("Air Conditioner")
								.font(.custom("Inconsolata-Regular", size: 15))
								.foregroundColor(.white)
						}
						
						Button(action: {isAC = false}) {
							Text(" ")
								.frame(width: 15, height: 15)
								.background(isAC ? Color.white : Color.buttonColor)
								.cornerRadius(50)
								.foregroundColor(.black)
								.padding()
								.overlay(RoundedRectangle(cornerRadius: 50)
									.stroke(.black, lineWidth: 3)
									.scaleEffect(0.4))
							Text("Light System")
								.font(.custom("Inconsolata-Regular", size: 15))
								.foregroundColor(.white)
						}
					}
					
					Text("Set Detail")
						.font(.custom("Inconsolata-Regular", size: 18))
						.foregroundColor(.white)
						.padding(.top, 10)
						.padding(.leading, 10)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					HStack {
						Text("Day: ")
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white)
							.padding(.top, 8)
							.padding(.leading, 30)
						
						Picker("", selection: $chosenDay) {
							ForEach(dayOfTheWeek, id: \.self) { string in
								Text(string).padding()
								
							}
						}.background(Color.backgroundColor)
							.frame(maxWidth: .infinity, alignment: .leading)
							.accentColor(.white)
							.padding(.top, 9)
							.padding(.leading, 100)
						
					}
					
					HStack {
						Text("Repeat: ")
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.buttonColor)
							.padding(.leading, 30)
						
						Toggle("", isOn: $isRepeat)
							.toggleStyle(SwitchToggleStyle(tint: .buttonColor))
							.padding(.trailing, 150)
							.font(.system(size: 10))
					}
					
					Text("Time: ")
						.font(.custom("Inconsolata-Regular", size: 18))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.leading, 10)
					
					Group {
						HStack {
							Toggle("", isOn: $isFrom)
								.toggleStyle(SwitchToggleStyle(tint: Color.onColor))
								.font(.system(size: 10))
							Text("From: ")
								.font(.custom("Inconsolata-Regular", size: 18))
								.foregroundColor(.white)
								.padding(.leading, 30)
							Picker("", selection: $chosenTimeFrom) {
								ForEach(0..<24, id: \.self){
									Text("\($0)")
								}
							}.background(Color.backgroundColor)
								.frame(maxWidth: .infinity, alignment: .leading)
								.accentColor(.white)
							Text(":")
								.font(.custom("Inconsolata-Regular", size: 18))
								.foregroundColor(.white)
								.padding(.trailing, 25)
							Picker("", selection: $chosenMinFrom) {
								ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self){
									Text("\($0)")
								}
							}.background(Color.backgroundColor)
								.frame(maxWidth: .infinity, alignment: .leading)
								.accentColor(.white)
						}
						
						HStack {
							Toggle("", isOn: $isTo)
								.toggleStyle(SwitchToggleStyle(tint: Color.onColor))
								.font(.system(size: 10))
							Text("  To: ")
								.font(.custom("Inconsolata-Regular", size: 18))
								.foregroundColor(.white)
								.padding(.leading, 30)
							Picker("", selection: $chosenTimeTo) {
								ForEach(0..<24, id: \.self){
									Text("\($0)")
								}
							}.background(Color.backgroundColor)
								.frame(maxWidth: .infinity, alignment: .leading)
								.accentColor(.white)
							
							Text(":")
								.font(.custom("Inconsolata-Regular", size: 18))
								.foregroundColor(.white)
								.padding(.trailing, 25)
							Picker("", selection: $chosenMinTo) {
								ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self){
									Text("\($0)")
								}
							}.background(Color.backgroundColor)
								.frame(maxWidth: .infinity, alignment: .leading)
								.accentColor(.white)
						}
						
						Group {
							HStack {
								Button(action: {
									dismiss()
								}) {
									Text("Cancel")
										.font(.custom("Inconsolata-Regular", size: 18))
										.padding([.horizontal],40)
										.padding([.vertical], 10)
										.background(Color.offColor)
										.foregroundColor(.white)
										.cornerRadius(8)
										.padding(.top, 80)
								}
								
								Button(action: {
									
								}) {
									Text("Submit")
										.font(.custom("Inconsolata-Regular", size: 18))
										.padding([.horizontal],40)
										.padding([.vertical], 10)
										.background(Color.buttonColor)
										.foregroundColor(.white)
										.cornerRadius(8)
										.padding(.top, 80)
								}
							}
						}
						
						
					}
					
					
					Spacer()
				}
				if self.showDeletePopup {
					GeometryReader { geometry in
						VStack {
							DeleteSchedulePopup()
						}.frame(maxWidth: .infinity, maxHeight: .infinity)
					}.background(Color.black.opacity(0.65)
						.edgesIgnoringSafeArea(.all)
						.onTapGesture {
							withAnimation{
								self.showDeletePopup.toggle()
							}
						})
				}
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
							Text("Room List")
								.font(.custom("Inconsolata-Regular", size: 20))
								.padding(.top, 5)
								.foregroundColor(.offColor)
						}
					}
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						dismiss()
					} label: {
						HStack {
							Button(action: {
								self.showDeletePopup.toggle()
								
							}) {
								Image(systemName: "xmark.bin")
									.font(.system(size: 13))
									.foregroundColor(.offColor)
									.padding(.top, 8)
									.padding(.trailing, 15)
							}
						}
					}
				}
			}
	}
}

struct EditScheduleView_Previews: PreviewProvider {
	static var previews: some View {
		EditScheduleView()
	}
}
