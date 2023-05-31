//
//  RoomInfoTimeListView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 23/04/2023.
//

import SwiftUI

struct RoomTimeListView: View {
	
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@EnvironmentObject var roomSettings: RoomSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	@State var savedRoomName = ""
	@State var showDeletePopup = false
	
	@State private var scheduleList = [ScheduleModel]()
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					List(scheduleList) { item in
						HStack {
							Group {
								VStack {
									Text("\(item.day)")
										.font(.custom("Inconsolata-Regular", size: 20))
										.padding(.top, 3)
										.foregroundColor(.dayColor)
									HStack {
										if item.isAC {
											Image(systemName: "air.conditioner.horizontal")
												.font(.system(size: 25))
												.foregroundColor(.white)
												.padding(.trailing, 10)
												.frame(width: 30)
										} else {
											Image(systemName: "lightbulb")
												.font(.system(size: 25))
												.foregroundColor(.white)
												.padding(.trailing, 10)
												.frame(width: 30)
										}
										Rectangle()
											.fill(Color.lineColor)
											.frame(width: 1)
										
										if item.isRepeat {
											Image(systemName: "repeat")
												.font(.system(size: 25))
												.foregroundColor(.buttonColor)
												.padding(.leading, 10)
												.frame(width: 30)
										} else {
											Image(systemName: "repeat")
												.font(.system(size: 25))
												.foregroundColor(Color.offColor)
												.padding(.leading, 10)
												.frame(width: 30)
										}
									}
								}.frame(width: 120, alignment: .center)
								
								Rectangle()
									.fill(Color.lineColor)
									.frame(width: 1)
								
								Group {
									VStack {
										HStack {
											if item.from == "-1" {
												Image(systemName: "play.fill")
													.font(.system(size: 25))
													.foregroundColor(Color.white)
													.frame(width: 30)
												Text("00:00")
													.font(.custom("Inconsolata-Regular", size: 20))
													.foregroundColor(.white)
													.padding(.leading, 30)
											} else {
												Image(systemName: "play.fill")
													.font(.system(size: 25))
													.foregroundColor(Color.buttonColor)
													.frame(width: 30)
												Text("\(item.from)")
													.font(.custom("Inconsolata-Regular", size: 20))
													.foregroundColor(Color.buttonColor)
													.padding(.leading, 30)
											}
										}
										HStack {
											
											if item.to == "-1" {
												Image(systemName: "stop.fill")
													.font(.system(size: 25))
													.foregroundColor(Color.white)
													.frame(width: 30)
												Text("00:00")
													.font(.custom("Inconsolata-Regular", size: 20))
													.padding(.top, 3)
													.foregroundColor(.white)
													.padding(.leading, 30)
											} else {
												Image(systemName: "stop.fill")
													.font(.system(size: 25))
													.foregroundColor(Color.buttonColor)
													.frame(width: 30)
												Text("\(item.to)")
													.font(.custom("Inconsolata-Regular", size: 20))
													.padding(.top, 3)
													.foregroundColor(Color.buttonColor)
													.padding(.leading, 30)
											}
										}
									}
								}.frame(width: 150, alignment: .leading)
									.padding(.leading, 20)
								
								NavigationLink(destination: EditScheduleView()) {
									
								}.isDetailLink(false)
								
								
							}
						}.listRowBackground(Color.backgroundColor)
							.padding(.top, 5)
					}.scrollContentBackground(.hidden)
						.background(Color.backgroundColor)
						.listStyle(.plain)
					
					Spacer()
					
				}

			}
		}.accentColor(Color.backgroundColor)
			.onAppear(perform: {
				getScheduleList()
			})
		
		
	}
	
	func getNeccessaryInfo() {
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		savedRoomName = UserDefaults.standard.string(forKey: settings.ROOM_NAME) ?? ""
		
	}
	
	func getScheduleList() {
		scheduleList = []
		scheduleList.append(ScheduleModel(scheduleId: "12345", day: "Monday", isAC: true, isRepeat: true, from: "13:00", to: "-1"))
//		scheduleList.append(ScheduleModel(scheduleId: "12346", day: "Tuesday", isAC: false, isRepeat: false, from: "-1", to: "11:00"))
//		scheduleList.append(ScheduleModel(scheduleId: "12345", day: "Thursday", isAC: true, isRepeat: true, from: "07:50", to: "11:30"))
	}
}
//
//struct RoomTimeListView_Previews: PreviewProvider {
//	static var previews: some View {
//		RoomTimeListView()
//	}
//}
