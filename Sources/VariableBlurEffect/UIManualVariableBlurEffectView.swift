//
//  UIManualVariableBlurEffectView.swift
//
//
//  Created by Noah Plützer on 27.05.24.
//

import Combine
import UIKit
import VariableBlurEffectObjc

public class UIManualVariableBlurEffectView: UIView {
    private let imageView = UIImageView()
    private lazy var displaylink = CADisplayLink(target: self, selector: #selector(displaylinkStep(_:)))
    
    public weak var renderSource: UIView?
    
    public var updatesManually: Bool = false {
        didSet {
            if updatesManually {
                displaylink.isPaused = true
                
            } else {
                displaylink.isPaused = false
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(imageView)
        displaylink.add(to: .main, forMode: .common)
        
        setNeedsDisplay()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = frame
        update()
    }
    
    public func update() {
        guard updatesManually else { return }
        
        updateBlurImage()
    }
    
    @objc
    private func displaylinkStep(_ displaylink: CADisplayLink) {
        updateBlurImage()
    }
    
    private func updateBlurImage() {
        guard let inputImage = renderSourceAsImage() ?? renderAsImage() else { return }
            
        let bluredImage = applyMaskedVariableBlur(image: inputImage)
            
        imageView.image = bluredImage
    }
    
    private func applyMaskedVariableBlur(image: UIImage) -> UIImage {
        guard let ciImage = CIImage(image: image) else { return UIImage() }
        let outputImage = OBJCGradientBlur.maskedVariableBlur(ciImage).cropped(to: ciImage.extent)
        
        let uiImage = UIImage(ciImage: outputImage)
        
        return uiImage
    }
    
    private func renderSourceAsImage() -> UIImage? {
        guard let renderSource = renderSource else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: frame.size)

        isHidden = true
        defer { self.isHidden = false }

        return renderer.image { rendererContext in
            renderSource.layer.render(in: rendererContext.cgContext)
        }
    }
}
