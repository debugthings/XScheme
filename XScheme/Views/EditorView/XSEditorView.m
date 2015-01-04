//
//  EditorView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView.h"
#import "XSConnectObjects.h"

@interface XSEditorView()

//@property XSObjectView *enterObject;
//@property XSObjectView *conjunctionObject;
//@property XSObjectView *disjunctionObject;
//@property XSObjectView *delayFirstObject;
//@property XSObjectView *delaySecondObject;
//@property XSObjectView *denielObject;
//@property XSObjectView *oneMoreConjunctionObject;
//@property XSObjectView *exitObject;

@property (readonly) NSScrollView *contentScrollView;

@end

@implementation XSEditorView

@synthesize contentScrollView = _contentScrollView;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        [self addSubview:self.contentScrollView];
        [self contentScrollViewConstraints];
        
        XSEnterObject *enterObject = [[XSEnterObject alloc] initSchemeObject];
        [self addSubview:enterObject];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[enterObject(48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(enterObject)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[enterObject(48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(enterObject)]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:enterObject
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:enterObject
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
        
//    [XSConnectObjects connectingLineBetweenObject:self.enterObject andObject:self.conjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.enterObject andObject:self.disjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.conjunctionObject andObject:self.delayFirstObject];
//    [XSConnectObjects connectingLineBetweenObject:self.disjunctionObject andObject:self.delaySecondObject];
//    [XSConnectObjects connectingLineBetweenObject:self.disjunctionObject andObject:self.denielObject];
//    [XSConnectObjects connectingLineBetweenObject:self.denielObject andObject:self.oneMoreConjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.delayFirstObject andObject:self.oneMoreConjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.delaySecondObject andObject:self.oneMoreConjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.conjunctionObject andObject:self.oneMoreConjunctionObject];
//    [XSConnectObjects connectingLineBetweenObject:self.oneMoreConjunctionObject andObject:self.exitObject];
}

#pragma mark - UI Elements

- (NSScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[NSScrollView alloc] init];
        _contentScrollView.backgroundColor = [NSColor workplaceBackgrountColor];
//        _contentScrollView.hasVerticalScroller = YES;
//        _contentScrollView.hasHorizontalScroller = YES;
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
