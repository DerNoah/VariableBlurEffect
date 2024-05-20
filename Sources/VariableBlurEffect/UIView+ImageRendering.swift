//
//  UIView+ImageRendering.swift
//  GradientBlurProject
//
//  Created by Noah Plützer on 20.04.24.
//

import UIKit

extension UIView {
    func renderAsImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        
        isHidden = true
        defer { self.isHidden = false }
        
        return renderer.image { rendererContext in
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.layer.render(in: rendererContext.cgContext)
        }
    }
    
    func createMaskImage(size: CGSize) -> CIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: .zero, size: size)
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
        }
        let maskImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return CIImage(image: maskImage!)!
    }
}
