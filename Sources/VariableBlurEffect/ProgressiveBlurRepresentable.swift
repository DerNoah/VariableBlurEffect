//
//  ProgressiveBlurRepresentable.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

struct ProgressiveBlurRepresentable: UIViewRepresentable {
	func makeUIView(context: Context) -> CustomBlurView {
		let view = CustomBlurView()
		view.backgroundColor = .clear
		return view
	}
	
	func updateUIView(_ uiView: CustomBlurView, context: Context) {}
}
