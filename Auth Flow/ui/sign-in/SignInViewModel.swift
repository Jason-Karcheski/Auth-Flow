//
//  SignInViewModel.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 20/08/2024.
//

import Foundation
import SwiftUI

extension SignInScreen {
	@Observable class ViewModel {
		var uiState = UiState()
		let signInUseCase: SignInUseCase
		
		init(uiState: UiState = UiState(), signInUseCase: SignInUseCase? = nil) {
			self.uiState = uiState
			self.signInUseCase = signInUseCase ?? SignInUseCase()
		}
		
		func attemptSignIn(onSuccess: () -> Void) {
			uiState.usernameError = validateUsername()
			uiState.passwordError = validatePassword()
			
			let credentialsAreValid = uiState.usernameError == nil && uiState.passwordError == nil
			if credentialsAreValid {
				switch signInUseCase.invoke() {
				case .success:
					uiState.signInError = nil
					onSuccess()
				case .failure:
					uiState.signInError = SignInError.SignInFailed
				}
			}
		}
		
		func updateStaySignedIn() {
			uiState.staySignedIn = !uiState.staySignedIn
		}
		
		private func validateUsername() -> SignInError? {
			let email = uiState.username
			
			switch true {
			case email.isEmpty:
				return SignInError.EmptyEmail
			case (email.contains("@") && (email.contains(".com") || email.contains(".co.uk"))) == false:
				return SignInError.InvalidEmail
			default:
				return nil
			}
		}
		
		private func validatePassword() -> SignInError? {
			let password = uiState.password
			
			switch true {
			case password.isEmpty:
				return SignInError.EmptyPassword
			case password.count < 8:
				return SignInError.InvalidPassword
			default:
				return nil
			}
		}
	}
	
	struct UiState {
		var username: String = ""
		var usernameError: SignInError? = nil
		var password: String = ""
		var passwordError: SignInError? = nil
		var staySignedIn: Bool = true
		var signInError: SignInError? = nil
	}
	
	enum SignInError: Error {
		case EmptyEmail, EmptyPassword, InvalidEmail, InvalidPassword, SignInFailed
		
		func getMessage() -> String {
			switch self {
			case .EmptyEmail:
				return "Email can't be empty"
			case .EmptyPassword:
				return "Password can't be empty"
			case .InvalidEmail:
				return "Email is invalid"
			case .InvalidPassword:
				return "Password is invalid"
			case .SignInFailed:
				return "Sign in unsuccessful"
			}
		}
	}
}

class SignInUseCase: UseCase {
	func invoke() -> Result<AppUser, SignInUseCaseError> {
		let fakeUser = AppUser(email: "fakeEmail", username: "Fake User")
		return Result.success(fakeUser)
	}
	
	enum SignInUseCaseError: Error {
		case SignInFailed
	}
}

protocol UseCase {
	associatedtype ReturnType
	associatedtype ErrorType: Error
	
	func invoke() -> Result<ReturnType, ErrorType>
}

struct AppUser {
	let id: UUID = UUID()
	let email: String
	let username: String
}
