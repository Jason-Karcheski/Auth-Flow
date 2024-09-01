//
//  AppHeader.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 22/08/2024.
//

import SwiftUI

struct AppScreenHeader: View {
	
	let title: String.LocalizationValue
	let subtitle: String.LocalizationValue?
	
	init(title: String.LocalizationValue, subtitle: String.LocalizationValue? = nil) {
		self.title = title
		self.subtitle = subtitle
	}
	
    var body: some View {
		VStack {
			Text(String(localized: title).capitalized)
				.font(subtitle == nil ? .title3 : .headline)
				.bold(subtitle == nil)
			
			if let subtitle {
				Text(String(localized: subtitle).capitalized)
					.font(.subheadline)
					.foregroundStyle(Color(uiColor: .systemGray))
			}
		}
		.frame(
			maxWidth: .infinity,
			alignment: .center
		)
		.padding()
    }
}

#Preview {
	VStack {
		AppScreenHeader(title: "preview header", subtitle: "example subtitle")
		AppScreenHeader(title: "Some header")
	}
}
