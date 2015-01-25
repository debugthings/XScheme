//
//  ObjectView.h
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface XSObjectView : XSView

@property (readonly) XSObjectType type;
@property (readonly) NSImage *image;
@property (readonly) NSColor *borderColor;
@property (nonatomic) NSInteger index;
@property (nonatomic) NSString *title;

@property (readonly) NSArray *inputConnections;
@property (readonly) NSArray *outputConnections;

@property (nonatomic) BOOL isListElement;

+ (XSObjectView *)duplicateSchemeObject:(XSObjectView *)objectView;

- (instancetype)initObjectWithType:(XSObjectType)objectType
                             title:(NSString *)title
                             image:(NSImage *)image
                       borderColor:(NSColor *)borderColor;

- (instancetype)initSchemeObject;
- (instancetype)initListObject;

- (void)showIndex;
- (void)hideIndex;

- (BOOL)isLogicalOperator;

- (void)setHighlightState:(BOOL)state;

- (NSInteger)inputsNumber;
- (NSInteger)outputsNumber;

- (XSObjectType)allowedInputTypes;
- (XSObjectType)allowedOutputTypes;

- (BOOL)isAllowedInputType:(XSObjectType)type;
- (BOOL)isAllowedOutputType:(XSObjectType)type;

- (BOOL)isHasInputs;
- (BOOL)isHasOutputs;

- (void)addInputConnectionObject:(XSObjectView *)object;
- (void)addOutputConnectionObject:(XSObjectView *)object;

- (void)removeInputConnectionObject:(XSObjectView *)object;
- (void)removeOutputConnectionObject:(XSObjectView *)object;

@end
