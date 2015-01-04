//
//  XSSeparatorView.m
//  XScheme
//
//  Created by Vladimir Shemet on 13.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSSeparatorView.h"

@implementation XSSeparatorView

- (id)init {
    self = [super initWithFrame:CGRectZero Color:[NSColor clearColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSGradient separatorGradient] drawInRect:dirtyRect angle:180];
}

@end
