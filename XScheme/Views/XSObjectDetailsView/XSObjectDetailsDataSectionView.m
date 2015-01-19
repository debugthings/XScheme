//
//  XSObjectDetailsDataSectionView.m
//  XScheme
//
//  Created by Vladimir Shemet on 19.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSObjectDetailsDataSectionView.h"
#import "XSNewConnectionButton.h"

static NSInteger const kSectionViewHeaderHeight = 15;
static NSInteger const kNewConnectionAreaHeight = 40;

@interface XSObjectDetailsDataSectionView()

@property (readonly) XSLabel *titleLabel;
@property (readonly) XSNewConnectionButton *newConnectionButton;

@end

@implementation XSObjectDetailsDataSectionView

@synthesize titleLabel = _titleLabel;
@synthesize newConnectionButton = _newConnectionButton;

- (instancetype)init {
    self = [super initWithColor:nil];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self titleLabelConstraints];
        [self addSubview:self.newConnectionButton];
        [self newConnectionButtonConstraints];
    }
    
    return self;
}

- (CGFloat)height {
    return kSectionViewHeaderHeight + kNewConnectionAreaHeight;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.titleLabel setStringValue:_title];
}

#pragma mark - UI Elements

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.backgroundColor = [NSColor colorWithRed:41.0f/255.0f green:42.0f/255.0f blue:43.0f/255.0f alpha:0.8f];
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont boldSystemFontOfSize:10.0f];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (XSNewConnectionButton *)newConnectionButton {
    if (!_newConnectionButton) {
        _newConnectionButton = [[XSNewConnectionButton alloc] init];
        _newConnectionButton.title = @"New connection";
        _newConnectionButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _newConnectionButton;
}

#pragma mark - UI Constraints

- (void)titleLabelConstraints {
    NSDictionary *metrics = @{@"titleHeight" : [NSNumber numberWithInteger:kSectionViewHeaderHeight]};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel(titleHeight)]"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
}

- (void)newConnectionButtonConstraints {
    NSDictionary *metrics = @{@"titleHeight" : [NSNumber numberWithInteger:kSectionViewHeaderHeight],
                              @"newConnectionAreaHeight" : [NSNumber numberWithInteger:kNewConnectionAreaHeight]};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_newConnectionButton]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_newConnectionButton)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=titleHeight)-[_newConnectionButton(newConnectionAreaHeight)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:NSDictionaryOfVariableBindings(_newConnectionButton)]];
    
}

@end