//
//  CompiledVariableBlurEffectView.swift
//  
//
//  Created by Noah Plützer on 20.05.24.
//

import UIKit

/// A variable blur view.
public class CompiledVariableBlurEffectView: UIVisualEffectView {
    private let gradientMask: UIImage
    private let maxBlurRadius: CGFloat
    private let filterType: String
    
    public init(
        gradientMask: UIImage = CompiledVariableBlurEffectViewConstants.defaultGradientMask,
        maxBlurRadius: CGFloat = 20,
        filterType: String = "variableBlur"
    ) {
        self.gradientMask = gradientMask
        self.maxBlurRadius = maxBlurRadius
        self.filterType = filterType
        
        super.init(effect: UIBlurEffect(style: .regular))
        
        applyVariableBlur()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            /// We have to re-apply when the appearance changes because the view updates its filters.
            self.applyVariableBlur()
        }
    }
    
    private func applyVariableBlur() {
        /// This is a private QuartzCore class, encoded in base64.
        ///
        ///             CAFilter
        let filterClassStringEncoded = "Q0FGaWx0ZXI="

        let filterClassString: String = {
            if
                let data = Data(base64Encoded: filterClassStringEncoded),
                let string = String(data: data, encoding: .utf8) {
                return string
            }

            print("[VariableBlurView] couldn't decode the filter class string.")
            return ""
        }()

        /// This is the magic class method that we want to invoke, encoded in base64.
        ///
        ///       filterWithType:
        let filterWithTypeStringEncoded = "ZmlsdGVyV2l0aFR5cGU6"

        /// Decode the base64.
        let filterWithTypeString: String = {
            if
                let data = Data(base64Encoded: filterWithTypeStringEncoded),
                let string = String(data: data, encoding: .utf8) {
                return string
            }

            print("[VariableBlurView] couldn't decode the filter method string.")
            return ""
        }()

        /// Create the selector.
        let filterWithTypeSelector = Selector(filterWithTypeString)

        /// Create the class object.
        guard let filterClass = NSClassFromString(filterClassString) as AnyObject as? NSObjectProtocol else {
            print("[VariableBlurView] couldn't create CAFilter class.")
            return
        }

        /// Make sure the filter class responds to the selector.
        guard filterClass.responds(to: filterWithTypeSelector) else {
            print("[VariableBlurView] Doesn't respond to selector \(filterWithTypeSelector)")
            return
        }

        /// Create the blur effect.
        let variableBlur = filterClass
            .perform(filterWithTypeSelector, with: filterType)
            .takeUnretainedValue()

        guard let variableBlur = variableBlur as? NSObject else {
            print("[VariableBlurView] Couldn't cast the blur filter.")
            return
        }

        /// The blur radius at each pixel depends on the alpha value of the corresponding pixel in the gradient mask.
        /// An alpha of 1 results in the max blur radius, while an alpha of 0 is completely unblurred.
        guard let gradientImageRef = gradientMask.cgImage else {
            fatalError("Could not decode gradient image")
        }

        variableBlur.setValue(maxBlurRadius, forKey: "inputRadius")
        variableBlur.setValue(gradientImageRef, forKey: "inputMaskImage")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")

        /// Get rid of the visual effect view's dimming/tint view, so we don't see a hard line.
        if subviews.indices.contains(1) {
            let tintOverlayView = subviews[1]
            tintOverlayView.alpha = 0
        }

        /// We use a `UIVisualEffectView` here purely to get access to its `CABackdropLayer`,
        /// which is able to apply various, real-time CAFilters onto the views underneath.
        let backdropLayer = subviews.first?.layer

        /// Replace the standard filters (i.e. `gaussianBlur`, `colorSaturate`, etc.) with only the variableBlur.
        backdropLayer?.filters = [variableBlur]
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
