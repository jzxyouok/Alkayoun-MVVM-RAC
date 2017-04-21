//
//  UIImageView+HTRoundImage.h
//  HeartTrip
//
//  Created by 熊彬 on 16/10/9.
//  Copyright © 2016年 BinBear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+HTRoundImage.h"

@interface UIImageView (HTRoundImage)

/***
 CornerRadius, imageURL, placeholder, size
 ***/
- (void)HT_setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(NSString *)placeholder
                               size:(CGSize)size;

/***
 CornerRadius, imageURL, placeholder, contentMode, size
 ***/
- (void)HT_setImageWithCornerRadius:(CGFloat)radius
                           imageURL:(NSURL *)imageURL
                        placeholder:(NSString *)placeholder
                        contentMode:(UIViewContentMode)contentMode
                               size:(CGSize)size;

/***
 HTRadius, imageURL, placeholder, size
 ***/
- (void)HT_setImageWithHTRadius:(HTRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(NSString *)placeholder
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;

/***
 HTRadius, imageURL, placeholder, contentMode, size
 ***/
- (void)HT_setImageWithHTRadius:(HTRadius)radius
                       imageURL:(NSURL *)imageURL
                    placeholder:(NSString *)placeholder
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth
                backgroundColor:(UIColor *)backgroundColor
                    contentMode:(UIViewContentMode)contentMode
                           size:(CGSize)size;
@end
