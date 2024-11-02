//
//  ProgressiveBlurView.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public class ProgressiveBlurView: UIView {
	public var viewController: ProgressiveBlurViewController? = nil
	public var radius: Double = 10
	public var effect: UIBlurEffect? = nil
	public var blurInsets: UIEdgeInsets = .zero
	
	public init(
		radius: Double = 10,
		effect: UIBlurEffect? = UIBlurEffect(style: .systemUltraThinMaterial),
		blurInsets: UIEdgeInsets = .zero
	) {
		self.radius = radius
		self.effect = effect
		self.blurInsets = blurInsets
		super.init(frame: .zero)
		setup()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		let viewController = ProgressiveBlurViewController(rootView: ProgressiveBlur(radius: radius, effect: effect))
		self.viewController = viewController
		
		addSubview(viewController.view)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		viewController?.view.frame = frame.inset(by: blurInsets)
	}
}
