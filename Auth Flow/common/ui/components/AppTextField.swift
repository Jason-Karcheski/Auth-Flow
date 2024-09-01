//
//  AppTextField.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 18/08/2024.
//

import Foundation
import SwiftUI

// MARK: Views

struct AppTextField: View {
	
	@Binding var text: String
	
	let isError: Bool
	let label: String.LocalizationValue
	let supportingText: String?
	let contentType: UITextContentType?
	let autoCapitalise: TextInputAutocapitalization?
	
	init(
		text: Binding<String>,
		isError: Bool,
		label: String.LocalizationValue,
		supportingText: String? = nil,
		contentType: UITextContentType? = nil,
		autoCapitalise: TextInputAutocapitalization? = nil
	) {
		self._text = text
		self.isError = isError
		self.label = label
		self.supportingText = supportingText
		self.contentType = contentType
		self.autoCapitalise = autoCapitalise
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			if contentType == .password {
				SecureField(
					String(localized: label),
					text: $text
				)
				.textContentType(contentType)
				.textInputAutocapitalization(autoCapitalise)
				.textFieldStyle(AppTextFieldStyle(isError: isError))
			} else {
				TextField(
					String(localized: label),
					text: $text
				)
				.textContentType(contentType ?? .none)
				.textInputAutocapitalization(autoCapitalise ?? .never)
				.textFieldStyle(AppTextFieldStyle(isError: isError))
			}
			
			if let supportingText {
				Text(supportingText)
					.foregroundStyle(isError ? .red : Color("AppOnPrimary"))
					.font(.caption)
			}
		}
	}
}

// MARK: Styles

struct AppTextFieldStyle: TextFieldStyle {
	
	let isError: Bool
	
	private let cornerRadius = 8.0
	
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding()
			.background(Color(UIColor.systemGray6))
			.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
			.foregroundStyle(isError ? .red : .black)
			.overlay {
				RoundedRectangle(cornerRadius: cornerRadius)
					.stroke(isError ? .red : .clear, lineWidth: isError ? 2.0 : 0.0)
			}
	}
}
