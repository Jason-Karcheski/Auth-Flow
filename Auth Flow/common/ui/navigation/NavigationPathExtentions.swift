//
//  extensions.swift
//  Auth Flow
//
//  Created by Jason Karcheski on 01/09/2024.
//

import Foundation
import SwiftUI

extension NavigationPath {
	mutating func navigateToRoute(_ route: Route) {
		self.append(route)
	}
	
	mutating func navigateBack() {
		if !self.isEmpty { self.removeLast() }
	}
}
