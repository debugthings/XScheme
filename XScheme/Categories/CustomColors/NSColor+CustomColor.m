//
//  NSColor+CustomColor.m
//  XScheme
//
//  Created by Vladimir Shemet on 29.11.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "NSColor+CustomColor.h"

@implementation NSColor (CustomColors)

- (NSColor *)workplaceBackgrountColor {
    return [NSColor colorWithHexColorString:@"0x26303b"];
}

+ (NSColor *)colorWithHexColorString:(NSString*)inColorString
{
    NSColor* result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:1.0];
    return result;
}

@end
