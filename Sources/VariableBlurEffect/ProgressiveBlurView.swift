//
//  ProgressiveBlurView.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public typealias VariableBlurView = ProgressiveBlurView

public class ProgressiveBlurView: UIView {
	public var viewController: ProgressiveBlurViewController? = nil
	public var blurInsets: UIEdgeInsets = .zero
	
	public init(blurInsets: UIEdgeInsets = .zero) {
		self.blurInsets = blurInsets
		super.init(frame: .zero)
		setup()
	}
	
	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
	
	private func setup() {
		let viewController = ProgressiveBlurViewController(rootView: ProgressiveBlur())
		self.viewController = viewController
		
		addSubview(viewController.view)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		viewController?.view.frame = frame.inset(by: blurInsets)
	}
}
