//
//  AppDelegate.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "AppDelegate.h"
#import "XSSplitView.h"
#import "XSTableView.h"

@interface AppDelegate()

@property (readonly) XSSplitView *splitView;

@end

@implementation AppDelegate

@synthesize splitView = _splitView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.window setFrame:[[NSScreen mainScreen] frame] display:YES animate:YES];
    
    [[self.window contentView] addSubview:self.splitView];
}

- (IBAction)segmentedControlAction:(NSSegmentedControl *)sender {
    if (sender.selectedSegment == 0)
        [[self.window contentView] replaceSubview:self.oneMoreView with:self.splitView];
    else {
        [self.oneMoreView setFrame:[[self.window contentView] bounds]];
        [self.oneMoreView analisysState:NO];
        [[self.window contentView] replaceSubview:self.splitView with:self.oneMoreView];
    }
}

- (IBAction)analisysAction:(NSButton *)sender {
    [[XSSchemeManager sharedManager] analisys];
}

- (void)showTableViewWithData:(NSArray *)data {
    [self.oneMoreView setFrame:[[self.window contentView] bounds]];
    [self.oneMoreView analisysState:YES];
    self.oneMoreView.dataArray = [[NSArray alloc] initWithArray:data];
    [[self.window contentView] replaceSubview:self.splitView with:self.oneMoreView];
}

#pragma mark - UI Elements

- (NSSplitView *)splitView {
    if (!_splitView) {
        _splitView = [[XSSplitView alloc] initWithFrame:[[self.window contentView] bounds]];
    }
    
    return _splitView;
}

@end
