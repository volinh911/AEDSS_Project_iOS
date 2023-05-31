//
//  InsertTokenPopupView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 17/05/2023.
//

import SwiftUI
import CryptoKit

struct InsertTokenPopupView: View {
	@State private var token: String = ""
	@State private var moveToNextScreen = false
	@Binding var email: String
	@State private var confirmPassword: String = ""
	@State private var password: String = ""
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	@State var savedAuth = ""
	@State var savedUserId = ""
	
	func convertToMd5(input: String) -> String {
			let digest = Insecure.MD5.hash(data: Data(input.utf8))
			
			return digest.map {
				String(format: "%02hhx", $0)
			}.joined()
		}
	
	var body: some View {
		VStack{
			Text("Input received token")
				.font(.custom("Inconsolata-Regular", size: 20))
				.foregroundColor(Color.buttonColor)

			UnderlineTextFieldView(
				text: $token,
				textFieldView: TextField("", text: $token)
					.font(.custom("Inconsolata-Regular", size: 18))
					.foregroundColor(.black),
				placeholder: "Token")
			.padding(.top, 10)
			.padding(.bottom, 20)
			
			Button(action: {
				let parameters: [String: Any] = ["email": email, "token": token]
				authenticationSettings.validateToken(parameters: parameters)
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
					print("\(authenticationSettings.isToken)")
					if authenticationSettings.isToken {
						self.moveToNextScreen = true
					}
				}
			}) {
				Text("OK")
					.font(.custom("Inconsolata-Regular", size: 18))
					.padding([.horizontal],30)
					.padding([.vertical], 10)
					.background(Color.buttonColor)
					.foregroundColor(.white)
					.cornerRadius(8)
			}
			if self.moveToNextScreen {
				VStack{
					UnderlineTextFieldView(
						text: $password,
						textFieldView: SecureField("", text: $password)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.black)
							.keyboardType(.emailAddress)
							.autocapitalization(.none),
						placeholder: "New Password")
					.padding(.top, 20)
					
					UnderlineTextFieldView(
						text: $confirmPassword,
						textFieldView: SecureField("", text: $confirmPassword)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.black),
						placeholder: "Confirm Password")
					.padding(.top, 40)
					
					Button(action: {
						getHeaders()
						if (self.password == self.confirmPassword) {
							let hashPass = convertToMd5(input: password)
							let parameters: [String: Any] = ["newPassword": hashPass]
							authenticationSettings.changePassword(auth: self.savedAuth, userid: self.savedUserId, parameters: parameters)
						}
					}) {
						Text("Submit")
							.font(.custom("Inconsolata-Regular", size: 18))
							.padding([.horizontal],80)
							.padding([.vertical], 10)
							.background(Color.buttonColor)
							.foregroundColor(.white)
							.cornerRadius(8)
							.padding(.top, 50)
					}
				}
			}
			
		}.padding()
			.background(Color.white)
			.cornerRadius(15)
			.onTapGesture {
				self.hideKeyboard()
			}
	}
	
	func getHeaders(){
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		print("auth: \(savedAuth)")
		print("userid: \(savedUserId)")
	}
}

struct InsertTokenPopupView_Previews: PreviewProvider {
	static var previews: some View {
		InsertTokenPopupView(email: .constant("volinh911@gmail.com"))
	}
}

