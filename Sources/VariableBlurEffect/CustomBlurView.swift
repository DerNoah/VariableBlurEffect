//
//  CustomBlurView.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import UIKit

final class CustomBlurView: UIVisualEffectView {
	init() {
		super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
		
		removeAllFilters()
		
		if #available(iOS 17.0, *) {
			registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _) in
				DispatchQueue.main.async {
					self.removeAllFilters()
				}
			}
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	
		if #unavailable(iOS 17.0) {
			DispatchQueue.main.async {
				self.removeAllFilters()
			}
		}
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func removeAllFilters() {
		if let filterLayer = layer.sublayers?.first {
			filterLayer.filters = []
		}
	}
}
