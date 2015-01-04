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

@interface XSObjectView : XSView

@property (readonly) XSObjectType type;

- (id)initSchemeObjectWithType:(XSObjectType)objectType
                         image:(NSImage *)image
                   borderColor:(NSColor *)borderColor;

- (id)initListObjectWithType:(XSObjectType)objectType
                        title:(NSString *)title
                        image:(NSImage *)image
                  borderColor:(NSColor *)borderColor;

@end
