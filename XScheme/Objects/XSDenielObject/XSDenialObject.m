//
//  XSDenialObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSDenialObject.h"

@implementation XSDenialObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeDenial
                               title:@"Отрицание"
                               image:[NSImage imageNamed:@"denial-icon"]
                         borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSNumber *)outputValue {
    if ([self.inputConnections count] == 1) {
        XSObjectView *inputObject = [self.inputConnections firstObject];
        
        if ([[inputObject outputValue] boolValue]) {
            [self setOutputValue:[NSNumber numberWithInteger:0]];
        } else {
            [self setOutputValue:[NSNumber numberWithInteger:1]];
        }
        
        return self.objectOutputValue;
    }
    
    return nil;
}

- (NSInteger)inputsNumber {
    return 1;
}

- (NSInteger)outputsNumber {
    return -1;
}

- (XSObjectType)allowedInputTypes {
    return kXSObjectTypeEnter | kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDelay | kXSObjectTypeDenial;
}

- (XSObjectType)allowedOutputTypes {
    return kXSObjectTypeConjunction | kXSObjectTypeDisjunction | kXSObjectTypeDelay | kXSObjectTypeDenial | kXSObjectTypeExit;
}

@end
