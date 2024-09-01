//
//  Auth_FlowApp.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 17/08/2024.
//

import SwiftUI

@main
struct AuthFlowApp: App {
	
	@State private var navigationPath = NavigationPath()
	private let isAuthenticated = false
	
    var body: some Scene {
        WindowGroup {
			NavigationStack(path: $navigationPath) {
				ProgressView()
					.frame(
						maxWidth: .infinity,
						maxHeight: .infinity,
						alignment: .center
					)
					.navigationDestination(for: Route.self) { route in
						navigateToRoute(route)
					}
					.onChange(of: navigationPath) { _, newValue in
						if newValue.isEmpty { navigateFromRouteView() }
					}
			}
			.onAppear {
				navigateFromRouteView()
			}
        }
    }
	
	@ViewBuilder
	private func navigateToRoute(_ route: Route) -> some View {
		switch route {
		case Route.CreateAccount:
			CreateAccountScreen(path: $navigationPath)
		case Route.Dashboard:
			Text("Dashboard")
		case Route.SignIn:
			SignInScreen(path: $navigationPath)
		}
	}
	
	private func navigateFromRouteView() {
		navigationPath.navigateToRoute(isAuthenticated ? .Dashboard : .SignIn)
	}
}
