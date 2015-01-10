//
//  NSColor+CustomColor.h
//  XScheme
//
//  Created by Vladimir Shemet on 29.11.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (CustomColors)

+ (NSColor *)workplaceBackgrountColor;
+ (NSColor *)sideMenuBackgroundColor;
+ (NSColor *)enterObjectBorderColor;
+ (NSColor *)objectsBackgroundColor;
+ (NSColor *)objectBorderColor;
+ (NSColor *)exitObjectBorderColor;

+ (NSColor *)lightGrayColorCustom;

+ (NSColor *)indexBackgroundColor;

+ (NSColor *)colorWithHexColorString:(NSString *)inColorString alpha:(CGFloat)alpha;

@end
