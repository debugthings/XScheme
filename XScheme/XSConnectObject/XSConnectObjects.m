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
@property (readonly) NSMutableArray *bezierPathsArray;

@end

@implementation XSConnectObjects

@synthesize bezierPathsArray = _bezierPathsArray;

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

+ (NSArray *)bezierPathsArray {
    return [[NSArray alloc] initWithArray:[[XSConnectObjects sharedObject] bezierPathsArray]];
}

+ (void)connectingLineBetweenObject:(id)firstObject andObject:(id)secondObject {
    if ([firstObject isKindOfClass:[NSView class]] && [secondObject isKindOfClass:[NSView class]]) {
        NSView *firstView = (NSView *)firstObject;
        NSView *secondView = (NSView *)secondObject;
        
        [NSBezierPath setDefaultLineWidth:1.0];
        NSBezierPath *bezierPath = [NSBezierPath bezierPath];
        
        CGPoint startPoint = [XSConnectObjects bottomConnectPoint:firstView.frame];
        CGPoint endPoint = [XSConnectObjects topConnectPoint:secondView.frame];
        
        if (startPoint.y <= endPoint.y)
            startPoint = [XSConnectObjects topConnectPoint:firstView.frame];
        
        [bezierPath moveToPoint:startPoint];
        [bezierPath lineToPoint:CGPointMake(startPoint.x, endPoint.y + 10)];
        [bezierPath lineToPoint:CGPointMake(endPoint.x, endPoint.y + 10)];
        [bezierPath lineToPoint:endPoint];
        
        [[NSColor lightGrayColorCustom] set];
        [bezierPath stroke];
        
        [XSConnectObjects insertPath:bezierPath];
    }
}

+ (CGPoint)bottomConnectPoint:(CGRect)frame {
    CGPoint point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y);
    return point;
}

+ (CGPoint)topConnectPoint:(CGRect)frame {
    CGPoint point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height);
    return point;
}

+ (void)insertPath:(NSBezierPath *)bezierPath {
    XSConnectObjects *connectionObject = [XSConnectObjects sharedObject];
    [connectionObject.bezierPathsArray addObject:bezierPath];
}

+ (void)removePath:(NSBezierPath *)bezierPath {
    XSConnectObjects *connectionObject = [XSConnectObjects sharedObject];
    [connectionObject.bezierPathsArray removeObject:bezierPath];
}

- (NSMutableArray *)bezierPathsArray {
    if (!_bezierPathsArray) {
        _bezierPathsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _bezierPathsArray;
}

@end
