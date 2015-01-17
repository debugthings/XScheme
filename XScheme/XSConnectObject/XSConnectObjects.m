//
//  XSConnectObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 17.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSConnectObjects.h"

@interface XSConnectObjects()

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
