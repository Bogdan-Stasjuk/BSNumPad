//
//  UIImage+Helpers.m
//  SBNumPadExample
//
//  Created by Bogdan Stasjuk on 6/10/14.
//  Copyright (c) 2014 Bogdan Stasjuk. All rights reserved.
//

#import "UIImage+Helpers.h"


@implementation UIImage (Helpers)

- (UIImage *)scale:(CGFloat)scale
{
    CGSize newSize = CGSizeMake(self.size.width * scale, self.size.height * scale);

    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end