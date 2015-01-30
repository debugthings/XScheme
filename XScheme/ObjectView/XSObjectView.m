//
//  ObjectView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSObjectView.h"
#import <Quartz/Quartz.h>

/*
    Вход             X
    Выход            Y
    Конъюнкция       ∧
    Дизъюнкция       ∨
    Отрицание        -
    Задержка (Delay) Z
*/

NSString * const XSListObjectBeginDragNotification  = @"XSListElementBeginDragNotification";
NSString * const XSListObjectEndDragNotification    = @"XSListElementEndDragNotification";
NSString * const XSListObjectDraggingNotification   = @"XSListObjectDraggingNotificaton";

NSString * const XSSchemeObjectDraggingNotification     = @"XSSchemeObjectDraggingNotification";
NSString * const XSSchemeObjectBeginDragNotification    = @"XSSchemeObjectBeginDragNotification";
NSString * const XSSchemeObjectEndDragNotification      = @"XSSchemeObjectEndDragNotification";

NSString * const XSSchemeObjectSelectNotification       = @"XSSchemeObjectSelectNotification";
NSString * const XSSchemeObjectRightClickNotification   = @"XSSchemeObjectRightClickNotification";

static NSInteger const kBorderWidth = 3;
static NSInteger const kCornerRadius = 24;

@interface XSObjectView() {
    BOOL _isDragging;
}

@property (readonly) XSView *contentView;
@property (readonly) XSLabel *titleLabel;
@property (readonly) NSImageView *imageView;
@property (readonly) XSLabel *indexLabel;
@property (readonly) XSView *highlightView;

@property (readonly) NSMutableArray *inputConnectionsArray;
@property (readonly) NSMutableArray *outputConnectionsArray;

@end

@implementation XSObjectView

@synthesize type = _type;
@synthesize imageView = _imageView;
@synthesize contentView = _contentView;
@synthesize titleLabel = _titleLabel;
@synthesize image = _image;
@synthesize borderColor = _borderColor;
@synthesize indexLabel = _indexLabel;
@synthesize highlightView = _highlightView;
@synthesize inputConnectionsArray = _inputConnectionsArray;
@synthesize outputConnectionsArray = _outputConnectionsArray;

@synthesize inputConnections = _inputConnections;
@synthesize outputConnections = _outputConnections;

+ (XSObjectView *)duplicateSchemeObject:(XSObjectView *)objectView {
    return [[[objectView class] alloc] initObjectWithType:objectView.type
                                                    title:objectView.title
                                                    image:objectView.image
                                              borderColor:objectView.borderColor];
}

- (id)initObjectWithType:(XSObjectType)objectType
                   title:(NSString *)title
                   image:(NSImage *)image
             borderColor:(NSColor *)borderColor {
    
    self = [super initWithColor:nil];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _type = objectType;
        _title = title;
        _borderColor = borderColor;
        _image = image;
        
        [self createContentView];
    }
    
    return self;
}

- (instancetype)initListObject {
    self = [self init];
    
    if (self) {
        self.isListElement = YES;
        
        [self.contentView removeConstraints:self.contentView.constraints];
        [self createContentView];
    }
    
    return self;
}

- (instancetype)initSchemeObject {
    self = [self init];
    
    if (self) {
        
    }
    
    return self;
}


- (void)setIsListElement:(BOOL)isListElement {
    _isListElement = isListElement;
    
    if (!_isListElement) {
        [self setFrame:CGRectMake(0, 0, 58, 58)];
    }
}

- (BOOL)isLogicalOperator {
    if ((kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDenial) & self.type)
        return YES;
    
    return NO;
}

#pragma mark - Inputs/Outputs numbers

- (NSInteger)inputsNumber {
    return -1;
}

- (NSInteger)outputsNumber {
    return -1;
}

#pragma mark - Allowed types

- (XSObjectType)allowedInputTypes {
    return 0;
}

- (XSObjectType)allowedOutputTypes {
    return 0;
}

- (BOOL)isAllowedInputType:(XSObjectType)type {
    if ([self allowedInputTypes] & type)
        return YES;
    
    return NO;
}

- (BOOL)isAllowedOutputType:(XSObjectType)type {
    if ([self allowedOutputTypes] & type)
        return YES;
    
    return NO;
}

#pragma mark - Inputs/Outputs object data

- (BOOL)isHasInputs {
    if ([self inputsNumber] != 0)
        return YES;
    
    return NO;
}

- (BOOL)isHasOutputs {
    if ([self outputsNumber] != 0)
        return YES;
    
    return NO;
}

#pragma mark - Index

- (void)showIndex {
    if (![self.subviews containsObject:self.indexLabel] && ![self isLogicalOperator])
        [self addSubview:self.indexLabel];
    
    [self.indexLabel setStringValue:[NSString stringWithFormat:@"%ld", (long)_index]];
}

- (void)hideIndex {
    [self.indexLabel removeFromSuperview];
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

- (void)setHighlightState:(BOOL)state {
    if (state) {
        [self.contentView addSubview:self.highlightView];
        [self highlightViewConstraints];
    } else {
        [self.highlightView removeFromSuperview];
    }
}

- (void)setTargetingState:(BOOL)state {
    if (state) {
        self.layer.borderColor = [NSColor blueColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 5.0f;
    } else {
        self.layer.borderWidth = 0.0f;
    }
}

#pragma mark - Operation with connections

- (void)addInputConnectionObject:(XSObjectView *)object {
    if (![self.inputConnectionsArray containsObject:object])
        [self.inputConnectionsArray addObject:object];
    
    if (![[object outputConnections] containsObject:self])
        [object addOutputConnectionObject:self];
}

- (void)addOutputConnectionObject:(XSObjectView *)object {
    if (![self.outputConnectionsArray containsObject:object])
        [self.outputConnectionsArray addObject:object];
    
    if (![[object inputConnections] containsObject:self])
        [object addInputConnectionObject:self];
}

- (void)removeInputConnectionObject:(XSObjectView *)object {
    if ([self.inputConnectionsArray containsObject:object])
        [self.inputConnectionsArray removeObject:object];
    
    if ([[object outputConnections] containsObject:self])
        [object removeOutputConnectionObject:self];
}

- (void)removeOutputConnectionObject:(XSObjectView *)object {
    if ([self.outputConnectionsArray containsObject:object])
        [self.outputConnectionsArray removeObject:object];
    
    if ([[object inputConnections] containsObject:self])
        [object removeInputConnectionObject:self];
}

#pragma mark - Mouse respondes

- (void)mouseDown:(NSEvent *)theEvent {
    if (!self.isListElement)
        [[NSNotificationCenter defaultCenter] postNotificationName:XSSchemeObjectSelectNotification
                                                            object:self];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    if (!_isDragging) {
        _isDragging = YES;
        
        if (self.isListElement)
            [[NSNotificationCenter defaultCenter] postNotificationName:XSListObjectBeginDragNotification
                                                                object:self];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:XSSchemeObjectBeginDragNotification
                                                                object:self];
    }
    
    if (self.isListElement)
        [[NSNotificationCenter defaultCenter] postNotificationName:XSListObjectDraggingNotification
                                                            object:self
                                                          userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow]}];
    else
        [[NSNotificationCenter defaultCenter] postNotificationName:XSSchemeObjectDraggingNotification
                                                            object:self
                                                          userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow]}];
}

- (void)mouseUp:(NSEvent *)theEvent {
    if (_isDragging) {
        _isDragging = NO;
        
        if (self.isListElement)
            [[NSNotificationCenter defaultCenter] postNotificationName:XSListObjectEndDragNotification
                                                                object:self];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:XSSchemeObjectEndDragNotification
                                                                object:self];
    }
}

- (void)rightMouseDown:(NSEvent *)theEvent {
    if (!self.isListElement)
        [[NSNotificationCenter defaultCenter] postNotificationName:XSSchemeObjectRightClickNotification
                                                            object:self
                                                          userInfo:@{@"locationInWindow" : [NSValue valueWithPoint:theEvent.locationInWindow]}];
}

#pragma mark - Object data

- (NSMutableArray *)inputConnectionsArray {
    if (!_inputConnectionsArray)
        _inputConnectionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    return _inputConnectionsArray;
}

- (NSMutableArray *)outputConnectionsArray {
    if (!_outputConnectionsArray)
        _outputConnectionsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    return _outputConnectionsArray;
}

- (NSArray *)inputConnections {
    return [[NSArray alloc] initWithArray:self.inputConnectionsArray];
}

- (NSArray *)outputConnections {
    return [[NSArray alloc] initWithArray:self.outputConnectionsArray];
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
        _titleLabel.backgroundColor = nil;
        _titleLabel.font = [NSFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (XSLabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[XSLabel alloc] initWithFrame:CGRectMake(kSchemeObjectWidth - 20, kSchemeObjectHeight - 20, 20, 20)];
        [_indexLabel setWantsLayer:YES];
        _indexLabel.textColor = [NSColor whiteColor];
        [_indexLabel setAlignment:NSCenterTextAlignment];
        _indexLabel.font = [NSFont systemFontOfSize:12.0f];
        _indexLabel.backgroundColor = [NSColor indexBackgroundColor];
        _indexLabel.layer.cornerRadius = 10;
        _indexLabel.stringValue = @"1";
    }
    
    return _indexLabel;
}

- (XSView *)highlightView {
    if (!_highlightView) {
        _highlightView = [[XSView alloc] initWithColor:[NSColor colorWithCalibratedRed:12.0f/255.0f green:139.0f/255.0f blue:220.0f/255.0f alpha:0.3f]];
        [_highlightView setWantsLayer:YES];
        _highlightView.layer.cornerRadius = (kSchemeObjectHeight - 10) / 2;
        _highlightView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _highlightView;
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
    NSDictionary *metrics = nil;
    
    if (self.isListElement)
        metrics = @{@"indent" : @0};
    else
        metrics = @{@"indent" : @5};
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(indent)-[_imageView(48)]"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(indent)-[_imageView(48)]"
                                                                             options:0
                                                                             metrics:metrics
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

- (void)highlightViewConstraints {
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_highlightView]-5-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_highlightView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_highlightView]-5-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_highlightView)]];
}

@end