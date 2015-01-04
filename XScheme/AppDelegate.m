//
//  AppDelegate.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "AppDelegate.h"
#import "SplitView.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setFrame:[[NSScreen mainScreen] frame] display:YES animate:YES];
    
    SplitView *splitView = [[SplitView alloc] initWithFrame:[[self.window contentView] bounds]];
    [[self.window contentView] addSubview:splitView];
}

@end
