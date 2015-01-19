//
//  XSConnectObject.h
//  XScheme
//
//  Created by Vladimir Shemet on 17.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface XSConnectObjects : NSObject

+ (XSConnectObjects *)sharedObject;

- (void)drawLineInView:(XSView *)view atBeginPoint:(NSPoint)point;
- (void)redrawLineInView:(XSView *)view atPoint:(NSPoint)point;
- (void)removeLineInView:(XSView *)view;
- (NSBezierPath *)currentBezierPath;

+ (void)connectingLineBetweenObject:(id)firstObject andObject:(id)secondObject;
+ (NSArray *)bezierPathsArray;

@end
