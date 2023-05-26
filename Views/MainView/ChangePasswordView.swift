//
//  ChangePasswordView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 05/05/2023.
//

import SwiftUI

struct ChangePasswordView: View {
	@Environment(\.dismiss) private var dismiss
	@State private var confirmPassword: String = ""
	@State private var password: String = ""
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	
	@State var savedAuth = ""
	@State var savedUserId = ""
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					Text("surveillance")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
						.padding(.top, 10)
					Text("system")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
					Text("Reset password")
						.font(.custom("Inconsolata-Regular", size: 30))
						.foregroundColor(.offColor)
						.padding(.top, 10)
					
					UnderlineTextFieldView(
						text: $password,
						textFieldView: TextField("", text: $password)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white)
							.keyboardType(.emailAddress)
							.autocapitalization(.none),
						placeholder: "New Password")
					.padding(.top, 100)
					
					UnderlineTextFieldView(
						text: $confirmPassword,
						textFieldView: SecureField("", text: $confirmPassword)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white),
						placeholder: "Confirm Password")
					.padding(.top, 40)
					
					
					Button(action: {
						if (self.password == self.confirmPassword) {
							let parameters: [String: Any] = ["newPassword": self.password]
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
							.padding(.top, 100)
					}
					Button(action: {
						dismiss()
					}) {
						Text("Login?")
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
		}.onAppear(perform: {getHeaders()})
	}
	func getHeaders(){
		savedAuth = UserDefaults.standard.string(forKey: settings.AUTH) ?? ""
		savedUserId = UserDefaults.standard.string(forKey: settings.USERID) ?? ""
		print("auth: \(savedAuth)")
		print("userid: \(savedUserId)")
	}
}

struct ChangePasswordView_Previews: PreviewProvider {
	static var previews: some View {
		ChangePasswordView()
	}
}
