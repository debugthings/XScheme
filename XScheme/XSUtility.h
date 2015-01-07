//
//  XSUtility.h
//  XScheme
//
//  Created by Vladimir Shemet on 28.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const XSListObjectBeginDragNotification;
extern NSString * const XSListObjectEndDragNotification;

extern NSString * const XSObjectDraggingNotification;

extern NSString * const XSSchemeObjectBeginDragNotification;
extern NSString * const XSSchemeObjectEndDragNotification;

static NSInteger const kSchemeObjectHeight = 48;
static NSInteger const kSchemeObjectWidth = 48;

@interface XSUtility : NSObject

+ (CGRect)windowContentViewRect;
+ (CGFloat)windowContentViewHeight;
+ (CGFloat)windowContentViewWidth;
+ (NSPoint)mousePosition;

@end
