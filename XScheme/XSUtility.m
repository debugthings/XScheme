//
//  XSUtility.m
//  XScheme
//
//  Created by Vladimir Shemet on 28.12.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSUtility.h"
#import "AppDelegate.h"

@implementation XSUtility

+ (CGRect)windowContentViewRect {
    AppDelegate *appDelegate = [NSApplication sharedApplication].delegate;
    NSWindow *mainWindow = appDelegate.window;
    return [[mainWindow contentView] bounds];
}

+ (CGFloat)windowContentViewHeight {
    return [XSUtility windowContentViewRect].size.height;
}

+ (CGFloat)windowContentViewWidth {
    return [XSUtility windowContentViewRect].size.width;
}

+ (NSPoint)mousePosition {
    return [NSEvent mouseLocation];
}

+ (NSString *)keyForObjectType:(XSObjectType)type {
    NSString *key = @"";
    
    switch (type) {
        case kXSObjectTypeEnter:
            key = @"kXSObjectTypeEnter";
            break;
            
        case kXSObjectTypeExit:
            key = @"kXSObjectTypeExit";
            break;
            
        case kXSObjectTypeConjunction:
            key = @"kXSObjectTypeConjunction";
            break;
            
        case kXSObjectTypeDisjunction:
            key = @"kXSObjectTypeDisjunction";
            break;
            
        case kXSObjectTypeDenial:
            key = @"kXSObjectTypeDenial";
            break;
            
        case kXSObjectTypeDelay:
            key = @"kXSObjectTypeDelay";
            break;
            
        default:
            break;
    }
    
    return key;
}

@end
