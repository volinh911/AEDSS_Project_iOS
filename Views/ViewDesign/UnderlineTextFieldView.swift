//
//  UnderlineTextFieldView.swift
//  AEDSS_Project_iOS
//
//  Created by vtlinh on 04/04/2023.
//

import SwiftUI

struct UnderlineTextFieldView<TextFieldView>: View where TextFieldView: View {
	
	@Binding var text: String
	let textFieldView: TextFieldView
	let placeholder: String
	var imageName: String? = nil
	
	private var isTextFieldWithIcon: Bool {
		return imageName != nil
	}
	
	var body: some View {
		HStack {
			if isTextFieldWithIcon {
				iconImageView
			}
			underlineTextFieldView
		}
	}
}

// MARK: - Setups
extension UnderlineTextFieldView {
	private var iconImageView: some View {
		Image(imageName ?? "")
			.frame(width: 32, height: 32)
			.padding(.leading, 16)
			.padding(.trailing, 16)
	}
	
	private var underlineTextFieldView: some View {
		VStack {
			ZStack(alignment: .leading) {
				if text.isEmpty {
					placeholderView
				}
				
				textFieldView
					.padding(.trailing, 20)
					.padding(.leading, isTextFieldWithIcon ? 0 : 20)
			}
			
			underlineView
		}
	}
	
	private var placeholderView: some View {
		Text(placeholder)
			.foregroundColor(.offColor)
			.padding(.leading, isTextFieldWithIcon ? 0 : 20)
			.opacity(0.5)
			.font(.custom("Inconsolata-Regular", size: 18))
	}
	
	private var underlineView: some View {
		Rectangle().frame(height: 1)
			.foregroundColor(.offColor)
			.padding(.trailing, 20)
			.padding(.leading, isTextFieldWithIcon ? 0 : 20)
	}
}
