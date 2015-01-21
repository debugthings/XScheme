//
//  ObjectLabel.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSLabel.h"

@implementation XSLabel

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    
    if (self) {
        [self setupLabelProperties];
    }
    
    return self;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self setupLabelProperties];
    }
    
    return self;
}

- (void)setupLabelProperties {
    [self setBezeled:NO];
    [self setDrawsBackground:NO];
    [self setEditable:NO];
    [self setSelectable:NO];
}

- (void)drawRect:(NSRect)dirtyRect {
    if (self.backgroundColor) {
        [self.backgroundColor setFill];
        NSRectFill(dirtyRect);
    }
    
    [super drawRect:dirtyRect];
}

@end
