//
//  Utils.h
//  dragDoctorClientIOS
//
//  Created by xukang on 14-1-9.
//  Copyright (c) 2014年 ubersexual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject

/*
 *  @param source
 *
 *  @param inputRadius
 *
 *  @return 高斯模糊图像
 */
+(UIImage*)CIGaussianBlur:(UIImage*)source inputRadius:(CGFloat)inputRadius;


/*
 *  @param view
 *
 *  @param rect
 *
 *  @return UIView截图
 */
+(UIImage *)viewCapture:(UIView *)view rect:(CGRect)rect;


@end
