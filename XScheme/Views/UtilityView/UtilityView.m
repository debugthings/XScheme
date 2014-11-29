//
//  UtilityView.m
//  XScheme
//
//  Created by Vladimir Shemet on 12.09.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "UtilityView.h"
#import "XSObjectView.h"
#import "XSLabel.h"

static NSInteger const kIndentBetweenObject = 20;

@implementation UtilityView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame Color:[NSColor sideMenuBackgroundColor]];
    
    if (self)
    {
        for(int i = 0; i < 6; i++)
        {
            NSInteger topPadding = kIndentBetweenObject + ((kIndentBetweenObject + 48) * i);
            
            
            NSDictionary *metrics = @{@"topPadding":[NSNumber numberWithInteger:topPadding]};
            
            XSObjectView *object = [[XSObjectView alloc] initObject:i];
            XSView *line = [[XSView alloc] initWithFrame:CGRectZero Color:[NSColor lightGrayColorCustom]];
            line.translatesAutoresizingMaskIntoConstraints = NO;
            
            XSLabel *label = [[XSLabel alloc] init];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            [label setAttributedStringValue:[object attributedString]];
            
            [self addSubview:object];
            [self addSubview:line];
            [self addSubview:label];
            
            NSDictionary *elements = NSDictionaryOfVariableBindings(object, line, label);
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[object]"
                                                                        options:0
                                                                        metrics:nil
                                                                           views:elements]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[object]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:elements]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[line]-8-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:elements]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[object]-10-[line(0.5)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:elements]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[object]-10-[label]-8-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:elements]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[label(48)]"
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:elements]];
            
        }
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}


#pragma mark - ObjectsView

- (NSView *)objectViewOrigin:(CGPoint)origin ObjectType:(NSInteger)objectType
{
    return nil;
}

@end
