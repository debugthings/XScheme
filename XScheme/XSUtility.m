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

@end
