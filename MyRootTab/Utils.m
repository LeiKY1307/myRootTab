//
//  Utils.m
//  dragDoctorClientIOS
//
//  Created by xukang on 14-1-9.
//  Copyright (c) 2014年 ubersexual. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
@implementation Utils

+(UIImage *)viewCapture:(UIView *)view rect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size,YES, 1.0);  //NO，YES控制是否透明
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect myImageRect = rect;
    
    CGImageRef imageRef = image.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef,myImageRect );
    
    
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    CGImageRelease(subImageRef);
    
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}


+(UIImage*)CIGaussianBlur:(UIImage*)source inputRadius:(CGFloat)inputRadius
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:source];
    
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setDefaults];
    [clampFilter setValue:inputImage forKey:kCIInputImageKey];
    
    
    // create gaussian blur filter
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:clampFilter.outputImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:inputRadius] forKey:@"inputRadius"];
    
    // blur image
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
//    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];//有多余的白边
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}


@end
