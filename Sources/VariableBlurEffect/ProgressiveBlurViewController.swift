//
//  ProgressiveBlurViewController.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public class ProgressiveBlurViewController: UIHostingController<ProgressiveBlur> {
	public convenience init(
		radius: Double = 10,
		effect: UIBlurEffect? = UIBlurEffect(style: .systemUltraThinMaterial)
	) {
		self.init(rootView: ProgressiveBlur(radius: radius, effect: effect))
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
	}
}
