//
//  UIImage+ImgColor.m
//  DFWTProject
//
//  Created by Administrator on 2022/11/9.
//  Copyright © 2022 Administrator. All rights reserved.
//

#import "UIImage+ImgColor.h"

@implementation UIImage (ImgColor)
+ (UIImage*)imageWithColor:(UIColor*) color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
