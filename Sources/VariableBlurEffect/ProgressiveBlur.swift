//
//  ProgressiveBlur.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public typealias VariableBlur = ProgressiveBlur

public struct ProgressiveBlur: View {
	private let radius: Double
	private let effect: UIBlurEffect?
	
	public init(
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
