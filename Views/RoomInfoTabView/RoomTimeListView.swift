//
//  RoomInfoTimeListView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 23/04/2023.
//

import SwiftUI

struct RoomTimeListView: View {
    var body: some View {
		ZStack {
			Color.backgroundColor.edgesIgnoringSafeArea(.all)
			
			VStack {
				Text("Hello, TimeList!")
			}
		}
        
    }
}

struct RoomTimeListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomTimeListView()
    }
}
