//
//  XSConnectObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 17.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSConnectObjects.h"

@interface XSConnectObjects()

@property (nonatomic, strong) NSBezierPath *currentPath;

@end

@implementation XSConnectObjects

+ (XSConnectObjects *)sharedObject {
    static XSConnectObjects *connectionObject = nil;
    static dispatch_once_t once_tocken;
    
    dispatch_once(&once_tocken, ^{
        connectionObject = [[XSConnectObjects alloc] init];
    });
    
    return connectionObject;
}

- (void)drawLineInView:(XSView *)view atBeginPoint:(NSPoint)point {
    self.currentPath = [NSBezierPath bezierPath];
    [self.currentPath setLineWidth:2.0f];
    [self.currentPath moveToPoint:point];
    [view setNeedsDisplay:YES];
}

- (void)redrawLineInView:(XSView *)view atPoint:(NSPoint)point {
    NSInteger elementCount = [self.currentPath elementCount];
    
    if (elementCount > 1) {
        [self.currentPath setAssociatedPoints:&point atIndex:1];
    } else {
        [self.currentPath lineToPoint:point];
    }
    
    [view setNeedsDisplay:YES];
}

- (void)removeLineInView:(XSView *)view {
    self.currentPath = nil;
    [view setNeedsDisplay:YES];
}

- (NSBezierPath *)currentBezierPath {
    return self.currentPath;
}

@end
