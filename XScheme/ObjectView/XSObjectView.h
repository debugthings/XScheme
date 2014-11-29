//
//  ObjectView.h
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum XSObjectType {
    
    kXSObjectTypeEnter,           /* ВХОД */
    kXSObjectTypeExit,            /* ВЫХОД */
    kXSObjectTypeConjunction,     /* КОНЪЮНКЦИЯ */
    kXSObjectTypeDisjunction,     /* ДИЗЪЮНКЦИЯ */
    kXSObjectTypeDenial,          /* ОТРИЦАНИЕ */
    kXSObjectTypeDelay            /* ЗАДЕРЖКА */
};

typedef enum XSObjectType XSObjectType;

@interface XSObjectView : NSView

@property (readonly) XSObjectType type;

- (id)initObject:(XSObjectType)objectType;

- (NSString *)title;
//- (NSString *)descriptionObject;
//- (NSAttributedString *)attributedString;

@end
