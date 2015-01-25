//
//  XSUtility.h
//  XScheme
//
//  Created by Vladimir Shemet on 28.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, XSObjectType) {
    kXSObjectTypeNone           = 0,
    kXSObjectTypeEnter          = 1 << 0,   /* ВХОД */
    kXSObjectTypeExit           = 1 << 1,   /* ВЫХОД */
    kXSObjectTypeConjunction    = 1 << 2,   /* КОНЪЮНКЦИЯ */
    kXSObjectTypeDisjunction    = 1 << 3,   /* ДИЗЪЮНКЦИЯ */
    kXSObjectTypeDenial         = 1 << 4,   /* ОТРИЦАНИЕ */
    kXSObjectTypeDelay          = 1 << 5    /* ЗАДЕРЖКА */
};

typedef NS_OPTIONS(NSUInteger, XSDataType) {
    XSDataTypeNone      = 0,
    XSDataTypeInput     = 1 << 0,
    XSDataTypeOutput    = 1 << 1
};

#pragma mark - List objects drag notifications

extern NSString * const XSListObjectBeginDragNotification;
extern NSString * const XSListObjectEndDragNotification;
extern NSString * const XSListObjectDraggingNotification;

#pragma mark - Scheme objects drag notifications

extern NSString * const XSSchemeObjectDraggingNotification;
extern NSString * const XSSchemeObjectBeginDragNotification;
extern NSString * const XSSchemeObjectEndDragNotification;

#pragma mark - Scheme objecs select notification

extern NSString * const XSSchemeObjectSelectNotification;

#pragma mark - Objects right click notification

extern NSString * const XSSchemeObjectRightClickNotification;

#pragma mark - Objects connecting notifications

extern NSString * const XSConnectingDragBeginNotification;
extern NSString * const XSConnectingDraggingNotification;
extern NSString * const XSConnectingDragEndNotification;

static NSInteger const kSchemeObjectHeight = 58;
static NSInteger const kSchemeObjectWidth = 58;

@interface XSUtility : NSObject

+ (CGRect)windowContentViewRect;
+ (CGFloat)windowContentViewHeight;
+ (CGFloat)windowContentViewWidth;
+ (NSPoint)mousePosition;

+ (NSString *)keyForObjectType:(XSObjectType)type;

@end
