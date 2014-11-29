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
    Задержка        -
    Отрицание       Z
*/

@implementation XSObjectView

@synthesize type = _type;

- (id)initObject:(XSObjectType)objectType
{
    self = [super init];
    
    if(self)
    {
        _type = objectType;
        
        [self setWantsLayer:YES];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = NSColorFromRGB(0xbfbfbf).CGColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self(==48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(self)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(==48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(self)]];
        
        XSView *blueView = [[XSView alloc] initWithFrame:CGRectMake(2, 2, 44, 44) Color:NSColorFromRGB(0xc0d4e5)];
        
        XSLabel *label = [[XSLabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [label setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
        [label setTextColor:[NSColor whiteColor]];
        label.alignment = NSCenterTextAlignment;
        
        switch (objectType)
        {
            case kXSObjectTypeEnter:
                label.stringValue = @"x";
                break;
            
            case kXSObjectTypeExit:
                label.stringValue = @"y";
                break;
                
            case kXSObjectTypeConjunction:
                label.stringValue = @"∧";
                break;
                
            case kXSObjectTypeDisjunction:
                label.stringValue = @"∨";
                break;
                
            case kXSObjectTypeDenial:
                label.stringValue = @"—";
                break;
                
            case kXSObjectTypeDelay:
                label.stringValue = @"z";
                break;
                
            default:
                break;
        }
        
        [blueView addSubview:label];
        
        [self addSubview:blueView];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
}

- (NSString *)title
{
    if(self.type == kXSObjectTypeConjunction)
        return @"Conjunction";
    if(self.type == kXSObjectTypeDisjunction)
        return @"Disjunction";
    if(self.type == kXSObjectTypeEnter)
        return @"Enter";
    if(self.type == kXSObjectTypeExit)
        return @"Exit";
    if(self.type == kXSObjectTypeDenial)
        return @"Deniel";
    if(self.type == kXSObjectTypeDelay)
        return @"Delay";
    
    return @"";
}

- (NSString *)descriptionObject
{
    if(self.type == kXSObjectTypeConjunction)
        return @"is a part of speech that connects words, sentences, phrases.";
    if(self.type == kXSObjectTypeDisjunction)
        return @"is a logical connective that represents operator is known as \"or\".";
    if(self.type == kXSObjectTypeEnter)
        return @"is a logical enter.";
    if(self.type == kXSObjectTypeExit)
        return @"is a logical exit.";
    if(self.type == kXSObjectTypeDenial)
        return @"is a logical deniel.";
    if(self.type == kXSObjectTypeDelay)
        return @"is a logical delay.";
    
    return @"";
}

- (NSAttributedString *)attributedString
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", [self title], [self descriptionObject]]];
    
    [attributedString addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"HelveticaNeue-Bold" size:13] range:NSMakeRange(0,[self title].length)];
    
    return attributedString;
}

@end
