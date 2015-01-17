//
//  AppDelegate.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "AppDelegate.h"
#import "XSSplitView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.window setFrame:[[NSScreen mainScreen] frame] display:YES animate:YES];
    
    XSSplitView *splitView = [[XSSplitView alloc] initWithFrame:[[self.window contentView] bounds]];
    [[self.window contentView] addSubview:splitView];
}

@end
