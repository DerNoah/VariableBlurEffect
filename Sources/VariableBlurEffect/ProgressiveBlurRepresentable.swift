//
//  ProgressiveBlurRepresentable.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

struct ProgressiveBlurRepresentable: UIViewRepresentable {
	private let effect: UIBlurEffect?
	
	init(effect: UIBlurEffect? = UIBlurEffect(style: .systemUltraThinMaterial)) {
		self.effect = effect
	}
	
	func makeUIView(context: Context) -> CustomBlurView {
		let view = CustomBlurView()
		view.backgroundColor = .clear
		return view
	}
	
	func updateUIView(_ uiView: CustomBlurView, context: Context) {
		if let animation = context.transaction.animation {
			if #available(iOS 18.0, *) {
				UIView.animate(animation, changes: {
					uiView.effect = self.effect
				})
			} else {
				UIView.animate(withDuration: 0.3) {
					uiView.effect = self.effect
				}
			}
		} else {
			uiView.effect = effect
		}
	}
}
