//
//  XSUtility.h
//  XScheme
//
//  Created by Vladimir Shemet on 28.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Foundation/Foundation.h>

enum XSObjectType {
    
    kXSObjectTypeEnter,           /* ВХОД */
    kXSObjectTypeExit,            /* ВЫХОД */
    kXSObjectTypeConjunction,     /* КОНЪЮНКЦИЯ */
    kXSObjectTypeDisjunction,     /* ДИЗЪЮНКЦИЯ */
    kXSObjectTypeDenial,          /* ОТРИЦАНИЕ */
    kXSObjectTypeDelay            /* ЗАДЕРЖКА */
};

typedef enum XSObjectType XSObjectType;

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
