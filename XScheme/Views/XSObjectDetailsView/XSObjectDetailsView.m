//
//  XSObjectDetailsView.m
//  XScheme
//
//  Created by Vladimir Shemet on 17.01.15.
//  Copyright (c) 2015 Vladimir Shemet. All rights reserved.
//

#import "XSObjectDetailsView.h"
#import "XSObjectDetailsDataSectionView.h"

static NSInteger const kTopIndent = 3;
static NSInteger const kHeaderHeight = 12;

@interface XSObjectDetailsView() <XSDataSectionDelegate>

@property (readonly) XSLabel *titleLabel;
@property (readonly) XSObjectDetailsDataSectionView *inputsSection;
@property (readonly) XSObjectDetailsDataSectionView *outputsSection;

@end

@implementation XSObjectDetailsView

@synthesize titleLabel = _titleLabel;
@synthesize inputsSection = _inputsSection;
@synthesize outputsSection = _outputsSection;

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 200, 200) Color:[NSColor colorWithRed:25.0f/255.0f green:25.0f/255.0f blue:26.0f/255.0f alpha:0.8f]];
    
    if (self) {
        [self setWantsLayer:YES];
        self.layer.cornerRadius = 7.5f;
        
        [self addSubview:self.titleLabel];
        [self titleLabelConstraints];
    }
    
    return self;
}

- (NSArray *)objectForSectionView:(XSObjectDetailsDataSectionView *)sectionView {
    if (sectionView == _inputsSection) {
        return @[@"1",@"2",@"3"];
//        return self.targetObject.inputConnections;
    } else if (sectionView == _outputsSection) {
        return @[@"1",@"2",@"3"];
//        return self.targetObject.outputConnections;
    }
    
    return nil;
}

- (void)reloadData {
    
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
    [_inputsSection removeFromSuperview];
    [_outputsSection removeFromSuperview];
    
    _inputsSection = nil;
    _outputsSection = nil;
    
    self.titleLabel.stringValue = self.targetObject.title;
    
    if ([self.targetObject isHasInputs]) {
        [self addSubview:self.inputsSection];
    }
    
    if ([self.targetObject isHasOutputs]) {
        [self addSubview:self.outputsSection];
    }
    
    [self configureFrame];
}

- (void)removeObjectsFromSuperview:(NSArray *)objectsArray {
    for (XSView *subview in objectsArray)
        [subview removeFromSuperview];
}

- (void)configureFrame {
    CGRect rect = self.frame;
    rect.size.height = kTopIndent + kHeaderHeight + 5;
    
    if (_inputsSection)
        rect.size.height += [_inputsSection height];
    
    if (_outputsSection)
        rect.size.height += [_outputsSection height];
    
    [self setFrame:rect];
    
    [self.titleLabel setFrame:CGRectMake(0, rect.size.height - kHeaderHeight - kTopIndent, rect.size.width, kHeaderHeight)];
    
    if (_inputsSection) {
        CGFloat inputHeight = [self.inputsSection height];
        [self.inputsSection setFrame:CGRectMake(0, rect.size.height - kHeaderHeight - kTopIndent - 3 - inputHeight, rect.size.width, inputHeight)];
    }
    
    if (_outputsSection) {
        CGFloat outputHeight = [self.outputsSection height];
        [self.outputsSection setFrame:CGRectMake(0, 0, rect.size.width, outputHeight)];
    }
}

#pragma mark - UI Elements

- (XSLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[XSLabel alloc] init];
        _titleLabel.backgroundColor = nil;
        _titleLabel.textColor = [NSColor whiteColor];
        _titleLabel.font = [NSFont boldSystemFontOfSize:11.0f];
        [_titleLabel setAlignment:NSCenterTextAlignment];
    }
    
    return _titleLabel;
}

- (XSObjectDetailsDataSectionView *)inputsSection {
    if (!_inputsSection) {
        _inputsSection = [[XSObjectDetailsDataSectionView alloc] init];
        _inputsSection.title = @"  Входные данные";
        _inputsSection.delegate = self;
        _inputsSection.dataType = XSDataTypeInput;
    }
    
    return _inputsSection;
}

- (XSObjectDetailsDataSectionView *)outputsSection {
    if (!_outputsSection) {
        _outputsSection = [[XSObjectDetailsDataSectionView alloc] init];
        _outputsSection.title = @"  Выходные данные";
        _outputsSection.delegate = self;
        _outputsSection.dataType = XSDataTypeOutput;
    }
    
    return _outputsSection;
}

#pragma mark - Constraints 

- (void)titleLabelConstraints {
    NSDictionary *metrics = @{@"topIndent" : [NSNumber numberWithInteger:kTopIndent],
                              @"headerHeight" : [NSNumber numberWithInteger:kHeaderHeight]};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topIndent)-[_titleLabel(headerHeight)]"
                                                                 options:0
                                                                 metrics:metrics
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_inputsSection(>=40)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_inputsSection)]];
    
}

- (void)outputsSectionConstraints {
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_outputsSection]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_outputsSection)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_outputsSection(>=40)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_outputsSection)]];
    
    if (_inputsSection)
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_inputsSection]-(0)-[_outputsSection]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_inputsSection, _outputsSection)]];
    else
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_outputsSection]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_outputsSection)]];
}

@end
