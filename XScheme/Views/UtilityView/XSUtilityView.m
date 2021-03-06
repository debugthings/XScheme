//
//  UtilityView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSUtilityView.h"
#import "XSObjectView.h"
#import "XSLabel.h"
#import "XSSeparatorView.h"

static NSInteger const kIndentBetweenObject = 20;

@interface XSUtilityView()

@property (readonly) NSScrollView *contentScrollView;

@end

@implementation XSUtilityView

@synthesize contentScrollView = _contentScrollView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor sideMenuBackgroundColor]];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resizeDocumentViewWithNotification:)
                                                     name:NSWindowDidEnterFullScreenNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeDocumentViewWithNotification:)
                                                     name:NSWindowDidExitFullScreenNotification
                                                   object:nil];
        
        [self addSubview:self.contentScrollView];
        [self contentScrollViewConstraints];
        
        NSView *contentView = [self contentView];
        [contentView setBoundsOrigin:CGPointMake(0, 0)];
        [self.contentScrollView setDocumentView:contentView];
    }
    
    return self;
}

- (NSView *)contentView {
    XSView *contentView = [[XSView alloc] initWithFrame:CGRectMake(0, 0, 190, [XSUtility windowContentViewHeight])
                                                  Color:[NSColor sideMenuBackgroundColor]];
    
    for (int i = 0; i < 6; i++) {
        id object = nil;
        
        if (i == 0)
            object = [[XSEnterObject alloc] initListObject];
        else if (i == 1)
            object = [[XSExitObject alloc] initListObject];
        else if (i == 2)
            object = [[XSConjunctionObject alloc] initListObject];
        else if (i == 3)
            object = [[XSDisjunctionObject alloc] initListObject];
        else if (i == 4)
            object = [[XSDelayObject alloc] initListObject];
        else if (i == 5)
            object = [[XSDenialObject alloc] initListObject];
        
        NSInteger topPadding = kIndentBetweenObject + ((kIndentBetweenObject + 48) * i);
        
        NSDictionary *metrics = @{@"topPadding":[NSNumber numberWithInteger:topPadding]};

        XSSeparatorView *line = [[XSSeparatorView alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        
        [contentView addSubview:object];
        [contentView addSubview:line];
        
        NSDictionary *elements = NSDictionaryOfVariableBindings(object, line);
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[object]-10-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:elements]];
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[object(50)]"
                                                                     options:0
                                                                     metrics:metrics
                                                                       views:elements]];
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[line]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:elements]];
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[object]-10-[line(0.5)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:elements]];
    }
    
    return contentView;
}

- (void)resizeDocumentViewWithNotification:(NSNotification *)notification {
    [self.contentScrollView.documentView setFrame:CGRectMake(0,
                                                             0,
                                                             [self.contentScrollView.documentView bounds].size.width,
                                                             [XSUtility windowContentViewHeight])];
}

- (CGRect)rectForDocumentViewInFullScreenMode {
    return CGRectMake(0, 0, [self.contentScrollView.documentView bounds].size.width, [XSUtility windowContentViewHeight]);
}

#pragma mark - UI Elements

- (NSScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[NSScrollView alloc] init];
        _contentScrollView.backgroundColor = [NSColor sideMenuBackgroundColor];
        _contentScrollView.borderType = NSNoBorder;
        [_contentScrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        _contentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _contentScrollView;
}

#pragma mark - UI Constraints

- (void)contentScrollViewConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentScrollView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentScrollView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentScrollView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentScrollView)]];
}

@end
