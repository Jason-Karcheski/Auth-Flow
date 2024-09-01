//
//  ContentView.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 17/08/2024.
//

import SwiftUI

struct SignInScreen: View {
	
	@State private var vm: ViewModel = ViewModel()
	@Binding var path: NavigationPath
	
    var body: some View {
		
		AppScreen(
			header: { AppScreenHeader(title: "sign-in") }
		) {
			AppTextField(
				text: $vm.uiState.username,
				isError: vm.uiState.usernameError != nil,
				label: "username",
				supportingText: vm.uiState.usernameError?.getMessage(),
				contentType: .emailAddress
			)
			
			AppTextField(
				text: $vm.uiState.password,
				isError: vm.uiState.passwordError != nil,
				label: "password",
				supportingText: vm.uiState.passwordError?.getMessage(),
				contentType: .password
			)
			
			Toggle("stay-signed-in", isOn: $vm.uiState.staySignedIn)
				.foregroundStyle(Color(.secondaryLabel))
				.tint(Color("AppPrimary"))
				.padding()
			
			Spacer()
			
			AppButton(label: "sign-in") {
				vm.attemptSignIn {
					path.append(Route.Dashboard)
				}
			}
			
			if let error = vm.uiState.signInError {
				Text(error.getMessage())
			}
			
			AppDivider(text: "or")
			
			AppButton(label: "create-account", style: .text) {
				path.append(Route.CreateAccount)
			}
		}
    }
}

#Preview {
	NavigationStack {
		SignInScreen(path: .constant(NavigationPath()))
	}
}
