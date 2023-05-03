//
//  LoginView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 04/04/2023.
//

import SwiftUI
import CryptoKit

struct LoginView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	
	func convertToMd5(input: String) -> String {
		let digest = Insecure.MD5.hash(data: Data(input.utf8))
		
		return digest.map {
			String(format: "%02hhx", $0)
		}.joined()
	}
	
	var body: some View {
		
		if authenticationSettings.isLoggedIn {
			RoomListView().environmentObject(authenticationSettings).environmentObject(RoomSettings())
		} else if UserDefaults.standard.bool(forKey: "login") == true {
			RoomListView().environmentObject(authenticationSettings).environmentObject(RoomSettings())
		}
		else {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					Text("surveillance")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
						.padding(.top, 50)
					Text("system")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
					
					
					UnderlineTextFieldView(
						text: $email,
						textFieldView: TextField("", text: $email)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white)
							.keyboardType(.emailAddress)
							.autocapitalization(.none),
						placeholder: "Email Address")
					.padding(.top, 120)
					
					UnderlineTextFieldView(
						text: $password,
						textFieldView: SecureField("", text: $password)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white),
						placeholder: "Password")
					.padding(.top, 40)
					
					
					Button(action: {
						if (!self.email.isEmpty && !self.password.isEmpty) {
							let hashPass = convertToMd5(input: password)
							print("email: \(email)")
							print("hashPass: \(hashPass)")
							
							let parameters: [String: Any] = ["email": email, "password": hashPass]
							authenticationSettings.postLoginUser(parameters: parameters)
						}
					}) {
						Text("Login")
							.font(.custom("Inconsolata-Regular", size: 18))
							.padding([.horizontal],80)
							.padding([.vertical], 10)
							.background(Color.buttonColor)
							.foregroundColor(.white)
							.cornerRadius(8)
							.padding(.top, 100)
					}
					Button(action: {
						
					}) {
						Text("Forgot Password?")
							.font(.custom("Inconsolata-Regular", size: 15))
							.foregroundColor(.white)
							.padding(.top, 10)
					}
					
					Spacer()
					
					Text("AEDSS")
						.font(.custom("Inconsolata-Regular", size: 20))
						.foregroundColor(.white)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding(.top, 50)
						.padding(.leading, 20)
				}
			}
			
		}
	}
}

//struct LoginView_Previews: PreviewProvider {
//	static var previews: some View {
//		LoginView()
//	}
//}
