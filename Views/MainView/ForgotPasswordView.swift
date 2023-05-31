//
//  ForgotPasswordView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 05/05/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
	@Environment(\.dismiss) private var dismiss
	
	@State private var email: String = ""
	@State private var token: String = ""
	@State var showInputTokenPopup = false
	@EnvironmentObject var authenticationSettings: AuthenticationSettings
	
	var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					Text("surveillance")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
						.padding(.top, 20)
					Text("system")
						.font(.custom("Inconsolata-Regular", size: 45))
						.foregroundColor(.white)
					Text("Forgot your password?")
						.font(.custom("Inconsolata-Regular", size: 25))
						.foregroundColor(.offColor)
						.padding(.top, 10)
					
					Text("Enter the email you use and you will receive an email containing a token for resetting your password")
						.font(.custom("Inconsolata-Regular", size: 15))
						.foregroundColor(.offColor)
						.padding(.top, 10)
						.multilineTextAlignment(.center)
						.fixedSize(horizontal: false, vertical: true)
						.padding(.leading, 10)
						.padding(.trailing, 10)
					
					UnderlineTextFieldView(
						text: $email,
						textFieldView: TextField("", text: $email)
							.font(.custom("Inconsolata-Regular", size: 18))
							.foregroundColor(.white)
							.keyboardType(.emailAddress)
							.autocapitalization(.none),
						placeholder: "Email")
					.padding(.top, 100)
					
					Button(action: {
						if (self.email.isEmpty) {
							print("No email insert")
						} else {
							let parameters: [String: Any] = ["email": email]
							authenticationSettings.checkEmail(parameters: parameters)
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
					}.onAppear(perform: {
						DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
							print("\(authenticationSettings.haveEmail)")
							if authenticationSettings.haveEmail {
								self.showInputTokenPopup.toggle()
							}
						}
					})
					
					
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
				if self.showInputTokenPopup {
					GeometryReader { geometry in
						VStack {
							InsertTokenPopupView(email: self.$email)
						}.frame(maxWidth: .infinity, maxHeight: .infinity)
					}.background(Color.black.opacity(0.65)
						.edgesIgnoringSafeArea(.all)
						.onTapGesture {
							withAnimation{
								self.showInputTokenPopup.toggle()
							}
						})
				}
			}
		}.onTapGesture {
			self.hideKeyboard()
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
						Text("Back")
							.font(.custom("Inconsolata-Regular", size: 20))
							.padding(.top, 5)
							.foregroundColor(.offColor)
					}
				}
			}
		}
	}
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}
