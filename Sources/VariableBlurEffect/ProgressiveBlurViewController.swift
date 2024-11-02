//
//  ProgressiveBlurViewController.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public typealias VariableBlurViewController = ProgressiveBlurViewController

public class ProgressiveBlurViewController: UIHostingController<ProgressiveBlur> {
	public convenience init() {
		self.init(rootView: ProgressiveBlur())
	}
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
	}
}
