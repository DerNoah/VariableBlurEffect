//
//  ProgressiveBlur.swift
//  VariableBlurEffect
//
//  Created by Noah Plützer on 02.11.24.
//

import SwiftUI

public typealias VariableBlur = ProgressiveBlur

public struct ProgressiveBlur: View {
	public init() {}
	
	public var body: some View {
		ProgressiveBlurRepresentable()
			.blur(radius: 10)
	}
}
