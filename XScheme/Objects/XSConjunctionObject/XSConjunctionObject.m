//
//  XSConjunctionObject.m
//  XScheme
//
//  Created by Vladimir Shemet on 16.10.14.
//  Copyright (c) 2014 Vladimir Shemet. All rights reserved.
//

#import "XSConjunctionObject.h"

@implementation XSConjunctionObject

- (instancetype)init {
    self = [super initObjectWithType:kXSObjectTypeConjunction
                               title:@"Конъюнкция"
                               image:[NSImage imageNamed:@"conjunction-icon"]
                         borderColor:[NSColor objectBorderColor]];
    
    if (self) {
        
    }
    
    return self;
}

- (NSNumber *)outputValue {
    if ([self.inputConnections count] == 2) {
        NSNumber *firstValue = [[self.inputConnections firstObject] outputValue];
        NSNumber *secondValue = [[self.inputConnections lastObject] outputValue];
        
        if (firstValue && secondValue) {
            [self setOutputValue:[NSNumber numberWithBool:([firstValue boolValue] && [secondValue boolValue])]];
            return self.objectOutputValue;
        }
    }
    
    return nil;}

- (NSInteger)inputsNumber {
    return 2;
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
