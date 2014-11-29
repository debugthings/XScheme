//
//  SplitView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "SplitView.h"
#import "XSEditorView.h"
#import "UtilityView.h"

@interface SplitView() <NSSplitViewDelegate>

@end

@implementation SplitView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code here.
        self.dividerStyle = NSSplitViewDividerStyleThin;
        [self setVertical:YES];
        
        XSEditorView *view1 = [[XSEditorView alloc] initWithFrame:CGRectMake([[self.window contentView] bounds].origin.x, [[self.window contentView] bounds].origin.y, 400, [[self.window contentView] bounds].size.height)];
        
        UtilityView *view2 = [[UtilityView alloc] initWithFrame:CGRectMake(view1.bounds.size.width, [[self.window contentView] bounds].origin.y, [[self.window contentView] bounds].size.width - 400, [[self.window contentView] bounds].size.height)];
        
        [self addSubview:view1];
        [self addSubview:view2];
        [self adjustSubviews];
        [self setPosition:100 ofDividerAtIndex:0];
        self.delegate = self;
        
        [self setPosition:([[NSScreen mainScreen] frame].size.width - 300) ofDividerAtIndex:0];
        self.autoresizingMask = NSViewHeightSizable;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark NSSplitViewDelegate

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMinimumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    return [[NSScreen mainScreen] frame].size.width - 300;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex
{
    return [[NSScreen mainScreen] frame].size.width - 200;
}

@end
