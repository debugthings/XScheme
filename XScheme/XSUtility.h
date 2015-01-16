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


extern NSString * const XSListObjectBeginDragNotification;
extern NSString * const XSListObjectEndDragNotification;
extern NSString * const XSListObjectDraggingNotification;

extern NSString * const XSSchemeObjectDraggingNotification;
extern NSString * const XSSchemeObjectBeginDragNotification;
extern NSString * const XSSchemeObjectEndDragNotification;

extern NSString * const XSSchemeObjectSelectNotification;

static NSInteger const kSchemeObjectHeight = 58;
static NSInteger const kSchemeObjectWidth = 58;

@interface XSUtility : NSObject

+ (CGRect)windowContentViewRect;
+ (CGFloat)windowContentViewHeight;
+ (CGFloat)windowContentViewWidth;
+ (NSPoint)mousePosition;

+ (NSString *)keyForObjectType:(XSObjectType)type;

@end
