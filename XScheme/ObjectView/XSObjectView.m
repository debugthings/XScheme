//
//  ObjectView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSObjectView.h"
#import <Quartz/Quartz.h>
#import "XSLabel.h"
#import "XSView.h"

/*
    Вход            X
    Выход           Y
    Конъюнкция      ∧
    Дизъюнкция      ∨
    Отрицание       -
    Задержка        Z
*/

static NSInteger const kBorderWidth = 3;
static NSInteger const kCornerRadius = 24;

@interface XSObjectView()

@property (nonatomic) BOOL isListElement;

@property (readonly) XSView *contentView;
@property (readonly) XSLabel *titleLabel;
@property (readonly) NSImageView *imageView;

@property (nonatomic) NSColor *borderColor;
@property (nonatomic) NSImage *image;
@property (nonatomic) NSString *title;

@end

@implementation XSObjectView

@synthesize type = _type;
@synthesize imageView = _imageView;
@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel;

/* Object for scheme */

- (id)initSchemeObjectWithType:(XSObjectType)objectType
                         image:(NSImage *)image
                   borderColor:(NSColor *)borderColor {
    
    self = [super initWithColor:[NSColor workplaceBackgrountColor]];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self setWantsLayer:YES];
        self.layer.cornerRadius = kCornerRadius;
        
        _type = objectType;
        _borderColor = borderColor;
        _image = image;
        
        [self createContentView];
    }
    
    return self;
}

/* Object with label for objects list */

- (id)initListObjectWithType:(XSObjectType)objectType
                        title:(NSString *)title
                        image:(NSImage *)image
                  borderColor:(NSColor *)borderColor {
    
    self = [super initWithColor:[NSColor sideMenuBackgroundColor]];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.isListElement = YES;
        _title = title;
        _type = objectType;
        _borderColor = borderColor;
        _image = image;
        
        [self createContentView];
    }
    
    return self;
}

- (void)createContentView {
    if (self.isListElement) {
        [self createListElementContentView];
    } else {
        [self createObjectContentView];
    }
}

- (void)createListElementContentView {
    [self addSubview:self.contentView];
    [self.imageView setImage:self.image];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    if (self.title)
        self.titleLabel.stringValue = self.title;
    
    [self contentViewConstraints];
    [self imageViewConstraints];
    [self titleLabelConstraints];
}

- (void)createObjectContentView {
    [self.imageView setImage:self.image];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    
    [self contentViewConstraints];
    [self imageViewConstraints];
}

#pragma mark - UI Elements

- (NSImageView *)imageView {
    if (!_imageView) {
        _imageView = [[NSImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        [_imageView setWantsLayer:YES];
        [_imageView.layer setBackgroundColor:[[NSColor whiteColor] CGColor]];
        _imageView.layer.cornerRadius = kCornerRadius;
        _imageView.layer.borderWidth = kBorderWidth;
        _imageView.layer.borderColor = self.borderColor.CGColor;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _imageView;
}

- (XSView *)contentView {
    if (!_contentView) {
        if (self.isListElement)
            _contentView = [[XSView alloc] initWithFrame:CGRectMake(0, 0, 100, 50) Color:[NSColor sideMenuBackgroundColor]];
        else {
            _contentView = [[XSView alloc] initWithFrame:CGRectMake(0, 0, 48, 48) Color:[NSColor clearColor]];
            [_contentView setWantsLayer:YES];
            _contentView.layer.cornerRadius = kCornerRadius;
        }
        
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _contentView;
}

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.font = [NSFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

#pragma mark - UI Constraints 

- (void)contentViewConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentView)]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contentView)]];
}

- (void)imageViewConstraints {
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_imageView(48)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_imageView(48)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_imageView)]];
}

- (void)titleLabelConstraints {
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                  constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView]-10-[_titleLabel]-10-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_titleLabel, _imageView)]];
}

@end