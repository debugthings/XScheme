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
        self.dividerStyle = NSSplitViewDividerStyleThick;
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

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)drawDividerInRect:(NSRect)rect {
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:29.0f/255.0f
                                                                                               green:29.0f/255.0f
                                                                                                blue:29.0f/255.0f
                                                                                               alpha:1.0f]
                                                         endingColor:[NSColor colorWithCalibratedRed:32.0f/255.0f
                                                                                               green:32.0f/255.0f
                                                                                                blue:32.0f/255.0f
                                                                                               alpha:1.0f]];
    [gradient drawInRect:rect angle:180];
//    [[NSColor redColor] set];
//    NSRectFill(rect);
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
