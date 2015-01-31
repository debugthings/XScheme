//
//  AppDelegate.h
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XSTableView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSSegmentedControl *segmentedControl;
@property (assign) IBOutlet XSTableView *oneMoreView;

- (IBAction)segmentedControlAction:(NSSegmentedControl *)sender;
- (IBAction)analisysAction:(NSButton *)sender;
- (void)showTableViewWithData:(NSArray *)data;

@end
