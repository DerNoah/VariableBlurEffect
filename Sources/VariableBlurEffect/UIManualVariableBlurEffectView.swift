//
//  UIManualVariableBlurEffectView.swift
//  
//
//  Created by Noah Plützer on 27.05.24.
//

import Combine
import UIKit

class UIManualVariableBlurEffectView: UIView {
    private let imageView = UIImageView()
    private lazy var displaylink = CADisplayLink(target: self, selector: #selector(displaylinkStep(_:)))
    
    weak var renderSource: UIView?
    
    var updatesManually: Bool = false {
        didSet {
            if updatesManually {
                displaylink.isPaused = true
                
            } else {
                displaylink.isPaused = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(imageView)
        displaylink.add(to: .main, forMode: .common)
        
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = frame
        update()
    }
    
    func update() {
        guard updatesManually else { return }
        
        updateBlurImage()
    }
    
    @objc
    private func displaylinkStep(_ displaylink: CADisplayLink) {
        updateBlurImage()
    }
    
    private func updateBlurImage() {
        guard let inputImage = renderSourceAsImage() ?? renderWholeScreenContextAsImage() else { return }
            
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
