//
//  CreateAccountScreen.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 20/08/2024.
//

import SwiftUI

struct CreateAccountScreen: View {
	
	@State private var vm: ViewModel = ViewModel()
	@Binding var path: NavigationPath
	
    var body: some View {
		AppScreen(
			header: { AppScreenHeader(title: "create-account") }
		) {
			AppTextField(
				text: $vm.uiState.email,
				isError: vm.uiState.emailError != nil,
				label: "email",
				supportingText: vm.uiState.emailError?.message,
				contentType: .emailAddress
			)
			
			AppTextField(
				text: $vm.uiState.password,
				isError: vm.uiState.passwordError != nil,
				label: "password",
				supportingText: vm.uiState.passwordError?.message,
				contentType: .password
			)
			
			AppTextField(
				text: $vm.uiState.confirmPassword,
				isError: vm.uiState.confirmPasswordError != nil,
				label: "confirm-password",
				supportingText: vm.uiState.confirmPasswordError?.message,
				contentType: .newPassword
			)
			
			Toggle("stay-signed-in", isOn: .constant(true))
				.foregroundStyle(Color(.secondaryLabel))
				.tint(.primary)
				.padding()
			
			Spacer()
			
			AppButton(label: "create-account") {
				vm.attemptAccountCreation()
			}
			
			AppDivider(text: "or")
			
			AppButton(label: "sign-in", style: .text) {
				path.isEmpty ? path.append(Route.SignIn) : path.removeLast()
			}
		}
    }
}

#Preview {
	NavigationStack {
		CreateAccountScreen(path: .constant(NavigationPath()))
	}
}
