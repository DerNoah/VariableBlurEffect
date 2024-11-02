//
//  ProgressiveBlur.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public struct ProgressiveBlur: View {
	let radius: Double
	let effect: UIBlurEffect?
	
	init(
		radius: Double = 10,
		effect: UIBlurEffect? = UIBlurEffect(style: .systemUltraThinMaterial)
	) {
		self.radius = radius
		self.effect = effect
	}
	
	public var body: some View {
		ProgressiveBlurRepresentable(effect: effect)
			.blur(radius: radius)
	}
}
