//
//  EditorView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSEditorView.h"
#import "XSObjectView.h"
#import "XSConnectObjects.h"

@interface XSEditorView()

@property XSObjectView *enterObject;
@property XSObjectView *conjunctionObject;
@property XSObjectView *disjunctionObject;
@property XSObjectView *delayFirstObject;
@property XSObjectView *delaySecondObject;
@property XSObjectView *denielObject;
@property XSObjectView *oneMoreConjunctionObject;
@property XSObjectView *exitObject;

@end

@implementation XSEditorView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame Color:[NSColor workplaceBackgrountColor]];
    if (self)
    {
        // Initialization code here.
        [self addObjects];
    }
    return self;
}

- (void)addObjects
{
    self.enterObject = [[XSObjectView alloc] initObject:kXSObjectTypeEnter];
    [self addSubview:self.enterObject];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.enterObject
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_enterObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject)]];
    
    self.conjunctionObject = [[XSObjectView alloc] initObject:kXSObjectTypeConjunction];
    [self addSubview:self.conjunctionObject];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_enterObject]-40-[_conjunctionObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _conjunctionObject)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_conjunctionObject]-40-[_enterObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _conjunctionObject)]];
    
    self.disjunctionObject = [[XSObjectView alloc] initObject:kXSObjectTypeDisjunction];
    [self addSubview:self.disjunctionObject];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_enterObject]-40-[_disjunctionObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _disjunctionObject)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_enterObject]-40-[_disjunctionObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _disjunctionObject)]];
    
    self.delayFirstObject = [[XSObjectView alloc] initObject:kXSObjectTypeDelay];
    [self addSubview:self.delayFirstObject];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_enterObject]-40-[_delayFirstObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _delayFirstObject)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_delayFirstObject]-40-[_conjunctionObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_delayFirstObject, _conjunctionObject)]];
    
    self.delaySecondObject = [[XSObjectView alloc] initObject:kXSObjectTypeDelay];
    [self addSubview:self.delaySecondObject];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_enterObject]-40-[_delaySecondObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _delaySecondObject)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_disjunctionObject]-40-[_delaySecondObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_delaySecondObject, _disjunctionObject)]];
    
    self.denielObject = [[XSObjectView alloc] initObject:kXSObjectTypeDenial];
    [self addSubview:self.denielObject];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_disjunctionObject]-40-[_denielObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_disjunctionObject, _denielObject)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_enterObject]-40-[_denielObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_enterObject, _denielObject)]];
    
    self.oneMoreConjunctionObject = [[XSObjectView alloc] initObject:kXSObjectTypeConjunction];
    [self addSubview:self.oneMoreConjunctionObject];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.oneMoreConjunctionObject
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_denielObject]-40-[_oneMoreConjunctionObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_denielObject, _oneMoreConjunctionObject)]];
    
    self.exitObject = [[XSObjectView alloc] initObject:kXSObjectTypeExit];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.exitObject
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_oneMoreConjunctionObject]-40-[_exitObject]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_oneMoreConjunctionObject, _exitObject)]];
    
    [self addSubview:self.exitObject];
    
    
    
    
    
//    id previousObject;
//    
//    for(int i = 0; i < 6; i++)
//    {
//        NSInteger topPadding = 10 + ((40 + 48) * i);
//        
//        
//        NSDictionary *metrics = @{@"topPadding":[NSNumber numberWithInteger:topPadding]};
//        
//        XSObjectView *object = [[XSObjectView alloc] initObject:i];
//        [self addSubview:object];
//        
//        NSDictionary *elements = NSDictionaryOfVariableBindings(object);
//        
//        
//        if(i == 0)
//            [self addConstraint:[NSLayoutConstraint constraintWithItem:object
//                                                             attribute:NSLayoutAttributeCenterX
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:object
//                                                             attribute:NSLayoutAttributeBaseline
//                                                            multiplier:10
//                                                              constant:10]];
//        
////        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=10)-[object]-(<=10)-|"
////                                                                     options:0
////                                                                     metrics:nil
////                                                                       views:elements]];
//        
//        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[object]"
//                                                                     options:0
//                                                                     metrics:metrics
//                                                                       views:elements]];
//        
//        previousObject = object;
//
//    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
        
    [XSConnectObjects connectingLineBetweenObject:self.enterObject andObject:self.conjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.enterObject andObject:self.disjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.conjunctionObject andObject:self.delayFirstObject];
    [XSConnectObjects connectingLineBetweenObject:self.disjunctionObject andObject:self.delaySecondObject];
    [XSConnectObjects connectingLineBetweenObject:self.disjunctionObject andObject:self.denielObject];
    [XSConnectObjects connectingLineBetweenObject:self.denielObject andObject:self.oneMoreConjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.delayFirstObject andObject:self.oneMoreConjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.delaySecondObject andObject:self.oneMoreConjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.conjunctionObject andObject:self.oneMoreConjunctionObject];
    [XSConnectObjects connectingLineBetweenObject:self.oneMoreConjunctionObject andObject:self.exitObject];
}

@end
