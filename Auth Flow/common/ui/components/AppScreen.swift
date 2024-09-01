//
//  AppScreen.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 22/08/2024.
//

import SwiftUI

struct AppScreen<Content: View>: View {
	
	let header: (() -> AppScreenHeader)?
	let content: Content
	
	init(
		header: (() -> AppScreenHeader)? = nil,
		@ViewBuilder content: () -> Content
	) {
		self.header = header
		self.content = content()
	}
	
    var body: some View {
		VStack {
			header?()
			
			VStack {
				content
					.navigationBarBackButtonHidden()
			}
			.padding()
		}
		.frame(
			maxWidth: .infinity,
			maxHeight: .infinity,
			alignment: .top
		)
    }
}

#Preview {
    AppScreen(
		header: { AppScreenHeader(title: "Preview Title", subtitle: "Example subtitle") }
	) {
		Text("example content")
	}
}
