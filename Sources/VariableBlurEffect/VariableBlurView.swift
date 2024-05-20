//
//  File.swift
//  
//
//  Created by Noah Plützer on 20.05.24.
//

import SwiftUI

public struct VariableBlurView: UIViewRepresentable {
    public var gradientMask: UIImage
    public var maxBlurRadius: CGFloat
    public var filterType: String

    /// A variable blur view.
    public init(
        gradientMask: UIImage = CompiledVariableBlurEffectViewConstants.defaultGradientMask,
        maxBlurRadius: CGFloat = 20,
        filterType: String = "variableBlur"
    ) {
        self.gradientMask = gradientMask
        self.maxBlurRadius = maxBlurRadius
        self.filterType = filterType
    }

    public func makeUIView(context: Context) -> CompiledVariableBlurEffectView {
        let view = CompiledVariableBlurEffectView(
            gradientMask: gradientMask,
            maxBlurRadius: maxBlurRadius,
            filterType: filterType
        )
        return view
    }

    public func updateUIView(_ uiView: CompiledVariableBlurEffectView, context: Context) {}
}
