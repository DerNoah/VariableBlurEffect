//
//  GradientBlurView.swift
//  GradientBlurProject
//
//  Created by Noah Plützer on 30.03.24.
//

import UIKit
import VariableBlurEffectObjc

public typealias UIVariableBlurEffectView = CompiledVariableBlurEffectView

private class VariableBlurEffectView: UIView {
    private let imageView = UIImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.frame = frame
    }
    
    private func setup() {
        createDisplayLink()
        addSubview(imageView)
        
        setNeedsDisplay()
    }
    
    private func createDisplayLink() {
        let displaylink = CADisplayLink(target: self, selector: #selector(displaylinkStep(_:)))
        displaylink.add(to: .current, forMode: .common)
    }
      
    @objc
    private func displaylinkStep(_ displaylink: CADisplayLink) {
        let inputImage = renderAsImage()!
            
        let bluredImage = applyMaskedVariableBlur(image: inputImage)

        imageView.image = bluredImage
    }
    
    private func applyMaskedVariableBlur(image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return UIImage() }
        let outputImage = OBJCGradientBlur.maskedVariableBlur(ciImage).cropped(to: ciImage.extent)
        
        let uiImage = UIImage(ciImage: outputImage)
        
        return uiImage
    }
}
