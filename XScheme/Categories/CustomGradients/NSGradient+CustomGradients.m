//
//  NSGradient+CustomGradients.m
//  XScheme
//
//  Created by Vladimir Shemet on 13.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "NSGradient+CustomGradients.h"

@implementation NSGradient (CustomGradients)

+ (NSGradient *)separatorGradient {
    return [[NSGradient alloc] initWithColorsAndLocations:[NSColor sideMenuBackgroundColor], 0.1, [NSColor lightGrayColorCustom], 0.6, [NSColor sideMenuBackgroundColor], 0.9, nil];
}

@end
