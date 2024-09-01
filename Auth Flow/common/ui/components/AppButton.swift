//
//  AppTextFieldStyle.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 17/08/2024.
//

import Foundation
import SwiftUI

// MARK: Views

struct AppButton: View {
	
	let label: String.LocalizationValue
	let style: AppButtonStyle
	let onPressed: () -> Void
	
	init(
		label: String.LocalizationValue,
		style: AppButtonStyle = .primary,
		disabled: Bool = false,
		onPressed: @escaping () -> Void
	) {
		self.label = label
		self.style = style
		self.onPressed = onPressed
	}
	
	var body: some View {
		Button {
			onPressed()
		} label: {
			Text(String(localized: label))
		}.appButtonStyle(style)
	}
}

extension Button {
	@ViewBuilder func appButtonStyle(_ style: AppButtonStyle) -> some View {
		switch style {
		case .text:
			self.buttonStyle(TextButton())
		default:
			self.buttonStyle(PrimaryButton())
		}
	}
}

// MARK: Styles

enum AppButtonStyle {
	case primary, text
}

struct PrimaryButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.frame(maxWidth: .infinity)
			.background(configuration.isPressed ? Color("AppPrimary").opacity(0.8) : Color("AppPrimary"))
			.foregroundStyle(Color("AppOnPrimary"))
			.clipShape(RoundedRectangle(cornerRadius: 16.0))
			.scaleEffect(configuration.isPressed ? CGFloat(0.97) : CGFloat(1.0))
			.font(.headline)
	}
}

struct TextButton: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.frame(maxWidth: .infinity)
			.background(configuration.isPressed ? Color(.systemGray6) : Color(.systemBackground))
			.foregroundStyle(configuration.isPressed ? Color("AppPrimary").opacity(0.8) : Color("AppPrimary"))
			.clipShape(RoundedRectangle(cornerRadius: 16.0))
			.overlay{
				RoundedRectangle(cornerRadius: 16.0)
					.stroke(Color(.systemGray6), lineWidth: 1.0)
			}
			.scaleEffect(configuration.isPressed ? CGFloat(0.97) : CGFloat(1.0))
			.font(.headline)
	}
}
