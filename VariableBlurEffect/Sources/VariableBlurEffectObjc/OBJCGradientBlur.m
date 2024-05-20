//
//  OBJCGradientBlur.m
//  GradientBlurProject
//
//  Created by Noah Plützer on 20.04.24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface OBJCGradientBlur : NSObject

/**
 Applies masked variable blur filter to a CIImage.

 @param inputImage The input CIImage to be blurred.
 @return The output CIImage with the applied blur effect.
 */
+ (CIImage *)maskedVariableBlur:(CIImage *)inputImage;

@end

@implementation OBJCGradientBlur : NSObject

+ (CIImage *)maskedVariableBlur:(CIImage *)inputImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIMaskedVariableBlur"];
    
    // Create a mask that goes from white to black vertically.
    CIFilter *mask = [CIFilter filterWithName:@"CISmoothLinearGradient"];
    [mask setValue:[CIColor colorWithRed:1.0 green:1.0 blue:1.0] forKey:@"inputColor0"];
    [mask setValue:[CIColor colorWithRed:0.0 green:0.0 blue:0.0] forKey:@"inputColor1"];
    [mask setValue:[CIVector vectorWithCGPoint:CGPointMake(0, inputImage.extent.size.height)] forKey:@"inputPoint0"];
    [mask setValue:[CIVector vectorWithCGPoint:CGPointMake(0, 0)] forKey:@"inputPoint1"];
    
    CIImage *maskImage = mask.outputImage;
    
    [filter setValue:inputImage.imageByClampingToExtent forKey:kCIInputImageKey];
    [filter setValue:maskImage forKey:@"inputMask"];
    [filter setValue:@(25) forKey:@"inputRadius"];
    
    CIImage *outputImage = filter.outputImage;
    
    return outputImage;
}

@end
