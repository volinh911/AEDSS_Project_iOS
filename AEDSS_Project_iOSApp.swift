//
//  AEDSS_Project_iOSApp.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 04/04/2023.
//

import SwiftUI

@main
struct AEDSS_Project_iOSApp: App {
    var body: some Scene {
        WindowGroup {
			LoginView().environmentObject(AuthenticationSettings()).environmentObject(AuthenticationAPI())
        }
    }
}
