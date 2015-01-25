//
//  XSNewConnectionButton.m
//  XScheme
//
//  Created by Vladimir Shemet on 19.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSNewConnectionButton.h"

NSString * const XSConnectingDragBeginNotification = @"XSConnectingDragBeginNotification";
NSString * const XSConnectingDragEndNotification = @"XSConnectingDragEndNotification";
NSString * const XSConnectingDraggingNotification = @"XSConnectingDraggingNotification";

@interface XSNewConnectionButton()

@property (readonly) XSLabel *titleLabel;

@end

@implementation XSNewConnectionButton

@synthesize titleLabel = _titleLabel;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self titleLabelConstraints];
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:XSConnectingDragBeginNotification
                                                        object:nil
                                                      userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow],
                                                                 @"dataType" : @(self.dataType)}];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:XSConnectingDraggingNotification
                                                        object:nil
                                                      userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow],
                                                                 @"dataType" : @(self.dataType)}];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [[NSNotificationCenter defaultCenter] postNotificationName:XSConnectingDragEndNotification
                                                        object:nil
                                                      userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow],
                                                                 @"dataType" : @(self.dataType)}];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [_titleLabel setStringValue:_title];
}

#pragma mark - UI Elements 

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.backgroundColor = nil;
        _titleLabel.alignment = NSCenterTextAlignment;
        _titleLabel.textColor = [NSColor sideMenuBackgroundColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

#pragma mark - UI Constraints

- (void)titleLabelConstraints {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
}

@end
