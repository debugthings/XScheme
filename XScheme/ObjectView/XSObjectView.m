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

@interface XSObjectView()

@property (readonly) NSImageView *imageView;

@end

@implementation XSObjectView

@synthesize type = _type;
@synthesize imageView = _imageView;

- (id)initObject:(XSObjectType)objectType
{
    self = [super init];
    
    if(self)
    {
        _type = objectType;
        
        [self setWantsLayer:YES];
        self.layer.borderWidth = 3.0f;
        self.layer.cornerRadius = 24.0f;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[self(==48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(self)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(==48)]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(self)]];
        
        [self addSubview:self.imageView];
        [self.imageView setImage:[self image]];
//        XSLabel *label = [[XSLabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        [label setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
//        [label setTextColor:[NSColor whiteColor]];
//        label.alignment = NSCenterTextAlignment;
        
        switch (objectType) {
            case kXSObjectTypeEnter:
                self.layer.borderColor = [NSColor enterObjectBorderColor].CGColor;
//                label.stringValue = @"x";
                break;
            
            case kXSObjectTypeExit:
                self.layer.borderColor = [NSColor exitObjectBorderColor].CGColor;
//                label.stringValue = @"y";
                break;
                
            case kXSObjectTypeConjunction:
                self.layer.borderColor = [NSColor objectBorderColor].CGColor;
//                label.stringValue = @"∧";
                break;
                
            case kXSObjectTypeDisjunction:
                self.layer.borderColor = [NSColor objectBorderColor].CGColor;
//                label.stringValue = @"∨";
                break;
                
            case kXSObjectTypeDenial:
                self.layer.borderColor = [NSColor objectBorderColor].CGColor;
//                label.stringValue = @"—";
                break;
                
            case kXSObjectTypeDelay:
                self.layer.borderColor = [NSColor objectBorderColor].CGColor;
//                label.stringValue = @"z";
                break;
                
            default:
                break;
        }
        
//        [self addSubview:label];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
}


- (NSString *)title {
    if(self.type == kXSObjectTypeConjunction)
        return @"Конъюнкция";
    if(self.type == kXSObjectTypeDisjunction)
        return @"Дизъюнкция";
    if(self.type == kXSObjectTypeEnter)
        return @"Вход";
    if(self.type == kXSObjectTypeExit)
        return @"Выход";
    if(self.type == kXSObjectTypeDenial)
        return @"Отрицание";
    if(self.type == kXSObjectTypeDelay)
        return @"Задержка";
    
    return @"";
}

- (NSImage *)image {
    if(self.type == kXSObjectTypeConjunction)
        return [NSImage imageNamed:@"conjunction-icon"];
    if(self.type == kXSObjectTypeDisjunction)
        return [NSImage imageNamed:@"disjunction-icon"];
    if(self.type == kXSObjectTypeEnter)
        return [NSImage imageNamed:@"enter-icon"];
    if(self.type == kXSObjectTypeExit)
        return [NSImage imageNamed:@"exit-icon"];
    if(self.type == kXSObjectTypeDenial)
        return [NSImage imageNamed:@"denial-icon"];
    if(self.type == kXSObjectTypeDelay)
        return [NSImage imageNamed:@"delay-icon"];
    
    return nil;
}
//- (NSString *)title
//{
//    if(self.type == kXSObjectTypeConjunction)
//        return @"Conjunction";
//    if(self.type == kXSObjectTypeDisjunction)
//        return @"Disjunction";
//    if(self.type == kXSObjectTypeEnter)
//        return @"Enter";
//    if(self.type == kXSObjectTypeExit)
//        return @"Exit";
//    if(self.type == kXSObjectTypeDenial)
//        return @"Deniel";
//    if(self.type == kXSObjectTypeDelay)
//        return @"Delay";
//    
//    return @"";
//}
//
//- (NSString *)descriptionObject
//{
//    if(self.type == kXSObjectTypeConjunction)
//        return @"is a part of speech that connects words, sentences, phrases.";
//    if(self.type == kXSObjectTypeDisjunction)
//        return @"is a logical connective that represents operator is known as \"or\".";
//    if(self.type == kXSObjectTypeEnter)
//        return @"is a logical enter.";
//    if(self.type == kXSObjectTypeExit)
//        return @"is a logical exit.";
//    if(self.type == kXSObjectTypeDenial)
//        return @"is a logical deniel.";
//    if(self.type == kXSObjectTypeDelay)
//        return @"is a logical delay.";
//    
//    return @"";
//}
//
//- (NSAttributedString *)attributedString
//{
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", [self title], [self descriptionObject]]];
//    
//    [attributedString addAttribute:NSFontAttributeName value:[NSFont fontWithName:@"HelveticaNeue-Bold" size:13] range:NSMakeRange(0,[self title].length)];
//    
//    return attributedString;
//}

#pragma mark - UI Elements

- (NSImageView *)imageView {
    if (!_imageView) {
        _imageView = [[NSImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    }
    
    return _imageView;
}

@end
