//
//  CreateAccountViewModel.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 20/08/2024.
//

import Foundation
import SwiftUI

extension CreateAccountScreen {
	@Observable class ViewModel {
		var uiState = UiState()
		
		func attemptAccountCreation() {
			uiState.emailError = validateEmail()
			uiState.passwordError = validatePassword()
			uiState.confirmPasswordError = validatePasswordConfirmation()
		}
		
		private func validateEmail() -> CreateAccountError? {
			let email = uiState.email
			
			switch true {
			case email.isEmpty:
				return CreateAccountError.EmptyEmail
			case (email.contains("@") && (email.contains(".com") || email.contains(".co.uk"))) == false:
				return CreateAccountError.InvalidEmail
			default:
				return nil
			}
		}
		
		private func validatePassword() -> CreateAccountError? {
			let password = uiState.password
			
			switch true {
			case password.isEmpty:
				return CreateAccountError.EmptyPassword
			case password.count < 8:
				return CreateAccountError.InvalidPassword
			default:
				return nil
			}
		}
		
		private func validatePasswordConfirmation() -> CreateAccountError? {
			let password = uiState.password
			let confirmPassword = uiState.confirmPassword
			
			switch true {
			case confirmPassword.isEmpty:
				return CreateAccountError.EmptyPassword
			case password != confirmPassword:
				return CreateAccountError.InvalidConfirmPassword
			default:
				return nil
			}
		}
	}
	
	enum CreateAccountError: Error {
		case EmptyEmail, InvalidEmail, EmptyPassword, InvalidPassword, InvalidConfirmPassword
		
		var message: String {
			return switch self {
			case .EmptyEmail:
				"Email cannot be empty"
			case .EmptyPassword:
				"Password cannot be empty"
			case .InvalidEmail:
				"Email is invalid"
			case .InvalidPassword:
				"Password is invalid"
			case .InvalidConfirmPassword:
				"Does not match the other password"
			}
		}
	}
	
	struct UiState {
		var email: String = ""
		var emailError: CreateAccountError? = nil
		var password: String = ""
		var passwordError: CreateAccountError? = nil
		var confirmPassword: String = ""
		var confirmPasswordError: CreateAccountError? = nil
		var staySignedIn: Bool = true
	}
}
