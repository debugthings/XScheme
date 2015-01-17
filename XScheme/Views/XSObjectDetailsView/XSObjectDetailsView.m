//
//  XSObjectDetailsView.m
//  XScheme
//
//  Created by Vladimir Shemet on 17.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSObjectDetailsView.h"

static NSInteger const kSectionHeaderHeight = 15;

@interface XSObjectDetailsView()

@property (readonly) XSLabel *titleLabel;
@property (readonly) XSView *inputsSection;
@property (readonly) XSView *outputsSection;

@property (nonatomic, strong) NSMutableArray *inputsViewArray;
@property (nonatomic, strong) NSMutableArray *outputsViewArray;

@end

@implementation XSObjectDetailsView

@synthesize titleLabel = _titleLabel;
@synthesize inputsSection = _inputsSection;
@synthesize outputsSection = _outputsSection;

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 200, 200) Color:[NSColor colorWithRed:25.0f/255.0f green:25.0f/255.0f blue:26.0f/255.0f alpha:0.8f]];
    
    if (self) {
        [self setWantsLayer:YES];
        self.layer.cornerRadius = 5;
        
        [self addSubview:self.titleLabel];
        [self titleLabelConstraints];
    }
    
    return self;
}

- (void)setFrameOrigin:(NSPoint)newOrigin {
    if (newOrigin.y < 0)
        newOrigin.y = 0;
    
    [super setFrameOrigin:newOrigin];
}

- (void)setTargetObject:(XSObjectView *)targetObject {
    if (![_targetObject isEqual:targetObject]) {
        _targetObject = targetObject;
        
        [self configureDetailsView];
    }
}

- (void)configureDetailsView {
    [self removeObjectsFromSuperview:self.inputsViewArray];
    [self removeObjectsFromSuperview:self.outputsViewArray];
    
    self.titleLabel.stringValue = self.targetObject.title;
    
    if (![self.subviews containsObject:self.inputsSection]) {
        [self addSubview:self.inputsSection];
        [self inputsSectionConstraints];
    }
}

- (void)removeObjectsFromSuperview:(NSArray *)objectsArray {
    for (XSView *subview in objectsArray)
        [subview removeFromSuperview];
}

- (XSLabel *)sectionTitleLabel {
    XSLabel *label = [[XSLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kSectionHeaderHeight)];
    label.backgroundColor = [NSColor colorWithRed:41.0f/255.0f green:42.0f/255.0f blue:43.0f/255.0f alpha:0.8f];
    label.textColor = [NSColor whiteColor];
    label.font = [NSFont boldSystemFontOfSize:10.0f];
    
    return label;
}

#pragma mark - UI Elements

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.backgroundColor = nil;
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont boldSystemFontOfSize:11.0f];
        [_titleLabel setAlignment:NSCenterTextAlignment];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (XSView *)inputsSection {
    if (!_inputsSection) {
        _inputsSection = [[XSView alloc] init];
        _inputsSection.translatesAutoresizingMaskIntoConstraints = NO;
        
        XSLabel *label = [self sectionTitleLabel];
        label.stringValue = @"  Входные данные";
        [_inputsSection addSubview:label];
    }
    
    return _inputsSection;
}

- (XSView *)outputsSection {
    if (!_outputsSection) {
        _outputsSection = [[XSView alloc] init];
        _outputsSection.translatesAutoresizingMaskIntoConstraints = NO;
        
        XSLabel *label = [self sectionTitleLabel];
        label.stringValue = @"  Выходные данные";
        [_outputsSection addSubview:label];
    }
    
    return _outputsSection;
}

#pragma mark - Constraints 

- (void)titleLabelConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_titleLabel(12)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLabel)]];
}

- (void)inputsSectionConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_inputsSection]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_inputsSection)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=20)-[_inputsSection(>=15)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_inputsSection)]];
    
}

@end
