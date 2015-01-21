//
//  XSAccessoryConnectingView.m
//  XScheme
//
//  Created by Vladimir Shemet on 20.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSAccessoryConnectingView.h"
#import "XSConnectObjects.h"

@implementation XSAccessoryConnectingView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect Color:nil];
    
    if (self) {
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSBezierPath *line = [[XSConnectObjects sharedObject] currentBezierPath];
    [[NSColor colorWithRed:54.0f/255.0f green:165.0f/255.0f blue:248.0f/255.0f alpha:1.0f] set];
    [line stroke];
}

@end
