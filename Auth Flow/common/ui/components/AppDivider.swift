//
//  AppDivider.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 19/08/2024.
//

import SwiftUI

struct AppDivider: View {
	
	let text: String.LocalizationValue?
	
	init(text: String.LocalizationValue? = nil) {
		self.text = text
	}
	
    var body: some View {
		ZStack(alignment: .center) {
			Divider()
			
			if let text {
				Text(String(localized: text).uppercased())
					.padding(.horizontal)
					.foregroundStyle(Color(UIColor.lightGray))
					.background(Color(UIColor.systemBackground))
					.font(.caption)
			}
		}
		.padding(.vertical, 4)
    }
}

#Preview {
    AppDivider(text: "Divider")
}
