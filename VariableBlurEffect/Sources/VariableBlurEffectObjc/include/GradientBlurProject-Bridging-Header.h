//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OBJCGradientBlur : NSObject

/**
 Applies masked variable blur filter to a CIImage.

 @param inputImage The input CIImage to be blurred.
 @return The output CIImage with the applied blur effect.
 */
+ (CIImage *)maskedVariableBlur:(CIImage *)inputImage;

@end

NS_ASSUME_NONNULL_END
