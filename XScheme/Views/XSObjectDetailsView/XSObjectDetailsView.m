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

@interface XSObjectDetailsView()

@property (readonly) XSLabel *titleLabel;
@property (readonly) XSObjectDetailsDataSectionView *inputsSection;
@property (readonly) XSObjectDetailsDataSectionView *outputsSection;

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
    [self setupData];
    
    self.titleLabel.stringValue = self.targetObject.title;
    
    if ([self.targetObject isHasInputs]) {
        [self addSubview:self.inputsSection];
        [self inputsSectionConstraints];
    }
    
    if ([self.targetObject isHasOutputs]) {
        [self addSubview:self.outputsSection];
        [self outputsSectionConstraints];
    }
    
    [self configureFrame];
}

- (void)setupData {
    [self removeObjectsFromSuperview:self.inputsViewArray];
    [self removeObjectsFromSuperview:self.outputsViewArray];
}

- (void)removeObjectsFromSuperview:(NSArray *)objectsArray {
    for (XSView *subview in objectsArray)
        [subview removeFromSuperview];
}

- (void)configureFrame {
    CGRect rect = self.frame;
    rect.size.height = kTopIndent + kHeaderHeight + 5 + [self.inputsSection height] + [self.outputsSection height];
    [self setFrame:rect];
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

- (XSObjectDetailsDataSectionView *)inputsSection {
    if (!_inputsSection) {
        _inputsSection = [[XSObjectDetailsDataSectionView alloc] init];
        _inputsSection.translatesAutoresizingMaskIntoConstraints = NO;
        _inputsSection.title = @"  Входные данные";
    }
    
    return _inputsSection;
}

- (XSObjectDetailsDataSectionView *)outputsSection {
    if (!_outputsSection) {
        _outputsSection = [[XSObjectDetailsDataSectionView alloc] init];
        _outputsSection.translatesAutoresizingMaskIntoConstraints = NO;
        _outputsSection.title = @"  Выходные данные";
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
}

@end
