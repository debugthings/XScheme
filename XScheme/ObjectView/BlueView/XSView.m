//
//  BlueView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSView.h"

@interface XSView()

@property (nonatomic, strong) NSColor *backgroundColor;

@end

@implementation XSView

- (id)initWithFrame:(NSRect)frame Color:(NSColor *)color
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = color;
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [self.backgroundColor setFill];
    NSRectFill(dirtyRect);
}

//NSColorFromRGB(0xc0d4e5)
@end
